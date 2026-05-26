import ../home.nix {
  username = "apika";
  homefile = ../../home/asce.nix;

  extra = inputs: [
    {
      imports = [
        inputs.sss.nixosModules.home-manager
        inputs.agenix.homeManagerModules.default
      ]; 
    }
  ];
}
