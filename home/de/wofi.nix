{ ... }:
{
  programs.wofi = {
    enable = true;
    settings = {
      "allow_images" = true;
      "image_size" = 24;
      "always_parse_args" = true;
      "height" = 480;
      "insensitive" = true;
      "print_command" =true;
      "prompt" = "Bonjour! Qu'est-ce que tu vas faire?";
      "show" = "drun";
      "show_all" = false;
      "width" = 600;
    };
    style = ''
      window {
      margin: 0px;
      /* border: 1px solid @theme_fg_color; */
      /* background-color: #282a36; */
      background-color: @theme_bg_color;
      }

      #input {
      margin: 5px;
      border: none;
      /* color: #f8f8f2; */
      color: @theme_text_color;
      /* background-color: #44475a; */
      background-color: @theme_bg_color;
      }

      #inner-box {
      margin: 2px;
      border: none;
      /* background-color: #282a36; */
      }

      #outer-box {
      margin: 2px;
      border: none;
      /* background-color: #282a36; */
      }

      #scroll {
      margin: 0px;
      border: none;
      }

      #text {
      margin: 5px;
      border: none;
      /* color: #f8f8f2; */
      color: @theme_text_color;
      } 

      #entry {
          margin-top: 2px;
          margin-bottom: 2px;
          margin-left: 20px;
      }

      #entry.activatable #text {
      /* color: #282a36; */
      }

      #entry > box {
          margin-left: 15px;
      /* color: #f8f8f2; */
      }

      #entry image {
          padding-right: 10px;
      }

      #entry:selected {
      /* background-color: #44475a; */
          /* background-color: @theme_selected_bg_color; */
          background-color: @theme_bg_color;
      }

      #entry:selected #text {
          /* color: @theme_selected_fg_color; */
      font-weight: bold;
      }
    '';
  };
}
