{
  plugins = {
    blink-cmp = {
      enable = true;
      setupLspCapabilities = true;

      settings = {
        keymap.preset = "super-tab";
        signature.enabled = true;

        sources = {
          default = [
            "lsp"
            "buffer"
            "path"
            "snippets"
          ];

          providers = {
            lsp.score_offset = 4;
          };
        };

        appearance = {
          nerd_font_variant = "mono";
          kind_icons = {
            Text = "󰉿";
            Method = "";
            Function = "󰊕";
            Constructor = "󰒓";
            Field = "󰜢";
            Variable = "󰆦";
            Property = "󰖷";
            Class = "󱡠";
            Interface = "󱡠";
            Struct = "󱡠";
            Module = "󰅩";
            Unit = "󰪚";
            Value = "󰦨";
            Enum = "󰦨";
            EnumMember = "󰦨";
            Keyword = "󰻾";
            Constant = "󰏿";
            Snippet = "󱄽";
            Color = "󰏘";
            File = "󰈔";
            Reference = "󰬲";
            Folder = "󰉋";
            Event = "󱐋";
            Operator = "󰪚";
            TypeParameter = "󰬛";
            Error = "󰏭";
            Warning = "󰏯";
            Information = "󰏮";
            Hint = "󰏭";
          };
        };

        completion = {
          menu = {
            border = "none";
            draw = {
              gap = 1;
              treesitter = [ "lsp" ];
              columns = [
                { __unkeyed-1 = "label"; }
                {
                  __unkeyed-1 = "kind_icon";
                  __unkeyed-2 = "kind";
                  gap = 1;
                }
                { __unkeyed-1 = "source_name"; }
              ];
            };
          };

          trigger.show_in_snippet = false;

          documentation = {
            auto_show = true;
            window.border = "single";
          };

          accept.auto_brackets.enabled = false;

          performance = {
            debounce_ms = 80;
            throttle_ms = 50;
            max_view_entries = 20;
          };
        };
      };
    };
  };
}
