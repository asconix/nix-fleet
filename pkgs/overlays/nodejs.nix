# Add Node.js overlay to fix build issues (https://github.com/NixOS/nixpkgs/issues/402079)
final: prev: {
  nodejs = prev.nodejs_22;
  "nodejs-slim" = prev."nodejs-slim_22";
}
