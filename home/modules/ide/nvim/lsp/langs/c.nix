{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = {
      clangd.enable = true;
      cmake.enable = true;
    };

    conform-nvim.settings = {
      formatters_by_ft = {
        c = [ "clang_format" ];
        cpp = [ "clang_format" ];
        cmake = [ "cmake-format" ];
      };
      formatters.cmake-format.command = lib.getExe pkgs.cmake-format;
    };
  };
}
