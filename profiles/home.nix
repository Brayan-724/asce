{
  username,
  homefile ? {},
  extra ? {},
}: {
  inputs,
  system,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit inputs;
      packages = inputs.self.packages.${system};
    };

    users.${username} = {
      imports = [homefile extra];

      home.stateVersion = "23.11";
    };
  };
}
