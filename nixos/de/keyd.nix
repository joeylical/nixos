{ ... }:
{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings = {
        # https://github.com/rvaiya/keyd
        main = {
          capslock = "esc";
          "control+esc" = "capslock";
        };
      };
    };
  };
}

