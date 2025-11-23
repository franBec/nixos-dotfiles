{ config, lib, ... }:
{
  dconf.settings = {
    "org/cinnamon/desktop/keybindings/custom-keybindings/custom0" = {
      name = "Rofi launcher";
      command = "rofi -show drun";
      binding = ["<Control>space"];
    };

    "org/cinnamon/desktop/keybindings/custom-keybindings" = {
      custom-list = [ "custom0" ];
    };
  };
}