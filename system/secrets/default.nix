{
  age = {
    identityPaths = [ "/home/apika/.ssh/apika.key" ];
    secrets.apika = {
      file = ./secrets.age;
      owner = "apika";
      group = "users";
    };
  };
}
