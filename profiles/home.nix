{
  username,
  homefile ? {},
  extra ? {},
}: {pkgs, ...}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.${username} = {
      imports = [homefile extra];

      home.stateVersion = "23.11";
    };
  };
}
