{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (st.overrideAttrs (oldAttrs: {
      src = fetchFromGitHub {
        owner = "elisiei";
        repo = "st";
        rev = "dd154987103b12df593a424fd238713201fbce54";
        sha256 = "sha256-/++WajhlI6zlE18DlslOn+qtoqxROxnZb63NK4MTeX0=";
      };

      nativeBuildInputs = oldAttrs.nativeBuildInputs or [ ] ++ [ pkg-config ];
      buildInputs = oldAttrs.buildInputs ++ [
        imlib2
        zlib
        harfbuzz
      ];

      preBuild = ''
        cp config.def.h config.h
      '';

      makeFlags = [ "CC=${pkgs.gcc}/bin/gcc" ];
      installFlags = [ "PREFIX=$(out)" ];
    }))
  ];
}
