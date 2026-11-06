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
    useGlobalPkgs = false;
    useUserPackages = true;
    backupFileExtension = "backup";

    extraSpecialArgs = {
      inherit inputs;
      packages = inputs.self.packages.${system};
    };

    users.${username} = {
      imports =
        (extra inputs)
        ++ [
          ../system/secrets
          homefile
        ];

      home.stateVersion = "23.11";
    };
  };
}
