{
  lib,
  stdenv,
  makeWrapper,
  python311,
  bubblewrap,
  nix,
  writeText,
  cage-config ? null,
}:
stdenv.mkDerivation rec {
  name = "nix-cage";
  buildInputs = [ python311 bubblewrap nix ];
  nativeBuildInputs = [ makeWrapper ];
  src = ./.;

  buildPhase = ''
    patchShebangs .
  '';

  extraWrapArgs = [] ++
    (if isNull cage-config then [] else [''--add-flags "--config ${writeText "nix-cage-config.json" (builtins.toJSON cage-config)}"'']);
      

  installPhase = ''
    source $stdenv/setup
    set -e

    mkdir -p $out/bin
    cp       $src/${name} $out/bin
    chmod +x $out/bin/${name}

    wrapProgram $out/bin/${name} \
      ${builtins.concatStringsSep " " extraWrapArgs} \
      --prefix PATH : ${lib.makeBinPath [
        bubblewrap
        nix
      ]}
  '';

  meta = {
    homepage = "https://github.com/pedohorse/nix-cage";
    description = "Sandboxed environments with nix-shell";

    longDescription = ''
      Sandboxed environments with bwrap
    '';

    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
