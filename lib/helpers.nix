{ inputs, outputs, stateVersion, ...}:
{
  mkDarwin = { hostname, username ? "ctp", system ? "aarch64-darwin",}:
  let
    inherit (inputs.nixpkgs) lib;
    unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
    customConfPath = ./../hosts/darwin/${hostname};
    customConf = if builtins.pathExists (customConfPath) then (customCon    fPath + "/default.nix") else ./../hosts/common/darwin-common-dock.nix;
  in
}