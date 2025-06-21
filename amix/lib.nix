rec {
  pipe = actions: value: builtins.foldl' (acc: action: action acc) value actions;

  /*
  Merge two values shallowly, left side is evaluated with right value.
  mergeMap :: (a -> a) -> a -> a
  */
  mergeMap = f: x:
    if builtins.typeOf x == "list"
    then x ++ (f x)
    else x // (f x);

  reduceMergeList = builtins.foldl' (acc: elm: acc ++ elm) [];
  reduceMergeAttrs = builtins.foldl' (acc: elm: acc // elm) {};

  attrsToList = set: builtins.attrValues (builtins.mapAttrs (name: value: {inherit name value;}) set);

  optionalField = default: field: set: set.${field} or default;
  optionalFieldAttr = optionalField {};
  optionalFieldList = optionalField [];

  removeElms = elms: list: builtins.filter (e: ! (builtins.elem e elms)) list;

  acceptAttrs = list: set: builtins.removeAttrs set (removeElms list (builtins.attrNames set));

  filterAttrs = f: set:
    builtins.listToAttrs (builtins.filter ({
      name,
      value,
    }:
      f name value) (attrsToList set));

  mapCompactAttrs = field: set:
    pipe [
      (builtins.mapAttrs (_: acceptAttrs [field]))
      (filterAttrs (_: builtins.hasAttr field))
    ]
    set;

  forceList = value:
    if builtins.typeOf value == "list"
    then value
    else [value];

  switch = val: possible: otherwise:
    if builtins.typeOf val == "string"
    then possible.${val} or otherwise
    else otherwise;

  removeSuffix = s: str: let
    sLen = builtins.stringLength s;
    strLen = builtins.stringLength str;
  in
    if sLen <= strLen && s == builtins.substring (strLen - sLen) sLen str
    then builtins.substring 0 (strLen - sLen) str
    else str;

  inspect = value: builtins.trace value value;
  inspectDeep = value: inspect (deepForce value);
  force = value: builtins.seq value value;
  deepForce = let
    deepSeq = v: builtins.deepSeq v v;
    getType = v: let
      t =
        v.type
        or v._type
        or (
          if v ? outPath
          then "derivation"
          else null
        );
    in
      if builtins.typeOf t == "string"
      then t
      else null;
  in
    value:
      switch (builtins.typeOf value) {
        "list" = deepSeq (builtins.map deepForce value);
        "set" =
          switch (getType value) {
            "derivation" = "«derivation @ ${getDrvName value}»";
            "option-type" = "«option-type»";
          }
          (
            if value ? outPath || value ? drvPath
            then "«derivation @ ${getDrvName value}»"
            else (deepSeq (builtins.mapAttrs (const deepForce) value))
          );
      }
      value;

  getPkgs = config: system: extraConfig:
    if config ? "pkgs"
    then config.pkgs
    else
      import config.pkgsFlake (
        {inherit system;}
        // config.pkgsConfig
        // extraConfig
      );

  isDerivation = value: value.type or null == "derivation";
  onlyDerivation = pkg: expr:
    if isDerivation pkg
    then expr
    else throw "pkg should be a derivation";

  getDrvName = pkg: onlyDerivation pkg (pkg.pname or ((builtins.parseDrvName pkg.name).name));

  getExe = pkg: getExe' pkg null;

  getExe' = pkg: binName: let
    bin =
      if builtins.typeOf binName == "string"
      then binName
      else getDrvName pkg;
  in
    onlyDerivation pkg
    "${pkg.bin or pkg.out}/bin/${bin}";

  const = x: _: x;
  isFunction = f: builtins.isFunction f || (f ? __functor && isFunction (f.__functor f));
  toFunction = v:
    if isFunction v
    then v
    else k: v;

  # TODO: Naming is pending.
  resolveConfig = name: values: let
    resolvePath = basePath: file: fileKind: let
      filePath = /${basePath}/${file};
    in
      if fileKind == "directory"
      then import /${filePath}/default.nix
      else if fileKind == "regular"
      then import filePath
      else null;

    resolvePaths = value: let
      valueType = builtins.readFileType value;
    in
      if valueType == "directory"
      then
        pipe [
          (builtins.mapAttrs (resolvePath value))
          (builtins.mapAttrs (name: value: {inherit name value;}))
          builtins.attrValues
          (builtins.filter ({value, ...}: value != null))
          builtins.listToAttrs
          (builtins.mapAttrs (const toFunction))
        ]
        (builtins.readDir value)
      else if valueType == "regular"
      then {${name} = toFunction (import value);}
      else abort "${name} path should be directory or file. but received: ${valueType}";

    resolve = value:
      if builtins.typeOf value == "path" || builtins.typeOf value == "string"
      then resolvePaths value
      else throw "${name} just can be reference to external files";
  in
    if builtins.typeOf values == "path" || builtins.typeOf values == "string"
    then resolvePaths values
    else if builtins.typeOf values == "list"
    then builtins.concatMap resolve values
    else if builtins.typeOf values == "lambda" || builtins.typeOf values == "set"
    then {${name} = toFunction values;}
    else abort "${name}s should be path-like, list, attrset or lambda.";
}
