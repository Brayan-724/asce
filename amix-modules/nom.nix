{
  pkgs,
  amixTypes,
  ...
}: {
  options.nom = with amixTypes; {
    inherit enable;
    pkg = pkg pkgs.nom;
  };
}
