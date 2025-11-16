{
  plugins = {
    conform-nvim.settings = {
      formatters = {
        odinfmt = {
          command = "odinfmt";
          args = [ "-stdin" ];
          stdin = true;
        };
      };
      formatters_by_ft = {
        odin = [ "odinfmt" ];
      };
    };
    lsp.servers = {
      ols = {
        enable = true;
      };
    };
  };
}
