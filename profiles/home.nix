{
  username,
  homefile ? {},
  extra ? {},
}: {inputs, system, pkgs, ...}: {
  home-manager = {

    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      packages = inputs.self.packages.${system};
    };

    users.${username} = {
      imports = [homefile extra];

      home.stateVersion = "23.11";
    };
  };
}
