{ ... }:

{
  programs.starship = {
    enable = true;
    enableTransience = true;
    enableFishIntegration = true;
    settings = {
      container.disabled = true;
      gcloud.disabled = true;
    };
  };
}