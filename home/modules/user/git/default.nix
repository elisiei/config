{
  programs.git = {
    enable = true;

    userName = "Elisiei Yehorov";
    userEmail = "yehorovye@disroot.org";

    signing = {
      key = "BA1D158DCE3DF089";
      signByDefault = true;
    };

    extraConfig = {
      tag.gpgSign = true;
      credential.helper = "store";
      push.default = "current";

      # @elisiei
      url."git@github.com-elisiei:".insteadOf = "https://github.com/elisiei/";
      url."git@github.com-elisiei:".pushInsteadOf = "https://github.com/elisiei/";

      # @yehorovye
      url."git@github.com-yehorovye:".insteadOf = "https://github.com/yehorovye/";
      url."git@github.com-yehorovye:".pushInsteadOf = "https://github.com/yehorovye/";
    };
  };
}
