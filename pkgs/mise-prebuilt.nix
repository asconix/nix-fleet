{ stdenv, fetchurl, lib }:

stdenv.mkDerivation rec {
  pname = "mise-prebuilt";
  version = "2026.4.6";

  src = fetchurl {
    url = "https://github.com/jdx/mise/releases/download/v${version}/mise-v${version}-macos-arm64.tar.gz";
    # Replace with the correct hash after first build attempt
    sha256 = lib.fakeSha256;
  };

  dontUnpack = false;

  installPhase = ''
    tar -xzf $src
    mkdir -p $out/bin
    mv mise $out/bin/
  '';

  meta = with lib; {
    description = "Prebuilt mise binary for macOS (arm64)";
    homepage = "https://github.com/jdx/mise";
    license = licenses.mit;
    platforms = platforms.darwin;
    maintainers = with maintainers; [ ];
  };
}
