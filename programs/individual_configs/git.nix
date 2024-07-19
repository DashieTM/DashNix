{
  programs.git = {
    enable = true;
    userName = "DashieTM";
    userEmail = "fabio.lenherr@gmail.com";
    extraConfig = {
      merge = {
        tool = "nvimdiff";
      };
      diff = {
        tool = "nvimdiff";
      };
    };
  };

}
