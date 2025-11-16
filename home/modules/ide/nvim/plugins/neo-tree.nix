{
  plugins.neo-tree = {
    enable = true;

    sources = [
      "filesystem"
      "buffers"
      "git_status"
    ];
    enableDiagnostics = true;
    enableGitStatus = true;
    enableModifiedMarkers = true;
    enableRefreshOnWrite = true;
    openFilesInLastWindow = true;

    extraOptions = {
      open_files_do_not_replace_types = [
        "terminal"
        "Trouble"
        "trouble"
        "qf"
        "Outline"
      ];

      filesystem = {
        bind_to_cwd = false;
        follow_current_file = {
          enabled = true;
        };
        use_libuv_file_watcher = true;
      };

      window.mappings = {
        "l" = "open";
        "h" = "close_node";
        "<space>" = "none";

        "Y" = {
          __raw = ''
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end
          '';
          desc = "Copy Path to Clipboard";
        };

        "O" = {
          __raw = ''
            function(state)
              vim.ui.open(state.tree:get_node().path)
            end
          '';
          desc = "Open with System Application";
        };
      };

      default_component_configs = {
        indent = {
          with_expanders = true;
          expander_collapsed = "";
          expander_expanded = "";
          expander_highlight = "NeoTreeExpander";
        };
        git_status.symbols = {
          unstaged = "󰄱";
          staged = "󰱒";
        };
      };
    };

    eventHandlers = {
      file_moved = ''
        function(data)
          require("snacks.rename").on_rename_file(data.source, data.destination)
        end
      '';
      file_renamed = ''
        function(data)
          require("snacks.rename").on_rename_file(data.source, data.destination)
        end
      '';
    };
  };

  keymaps = [
    {
      key = "<leader>fe";
      mode = [ "n" ];
      action = ''
        <cmd>lua require("neo-tree.command").execute({ toggle = true, dir = vim.fn.getcwd() })<CR>
      '';
      options.desc = "Explorer NeoTree (cwd)";
    }
    {
      key = "<leader>e";
      mode = [ "n" ];
      action = "<leader>fe";
      options.remap = true;
      options.desc = "Explorer NeoTree (cwd)";
    }
    {
      key = "<leader>ge";
      mode = [ "n" ];
      action = ''
        <cmd>lua require("neo-tree.command").execute({ source = "git_status", toggle = true })<CR>
      '';
      options.desc = "Git Explorer";
    }
    {
      key = "<leader>be";
      mode = [ "n" ];
      action = ''
        <cmd>lua require("neo-tree.command").execute({ source = "buffers", toggle = true })<CR>
      '';
      options.desc = "Buffer Explorer";
    }
  ];
}
