{
  plugins.snacks = {
    enable = true;
    autoLoad = true;
  };

  keymaps = [
    {
      key = "<leader>ff";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.files()<CR>";
      options.desc = "Find files";
    }
    {
      key = "<leader>fb";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.buffers()<CR>";
      options.desc = "Find buffers";
    }
    {
      key = "<leader>gl";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.git_log()<CR>";
      options.desc = "Git log";
    }
    {
      key = "<leader>gs";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.git_status()<CR>";
      options.desc = "Git status";
    }
    {
      key = "<leader>uC";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.colorschemes()<CR>";
      options.desc = "Colorschemes";
    }
    {
      key = "<leader>:";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.command_history()<CR>";
      options.desc = "Command history";
    }
  ];
}
