{
  username,
  homefile ? {},
  extra ? (_: []),
}: {
  inputs,
  system,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    extraSpecialArgs = {
      inherit inputs;
      packages = inputs.self.packages.${system};
    };

    users.${username} = {
      imports = (extra inputs) ++ [homefile];

      home.stateVersion = "23.11";
    };
  };
}
