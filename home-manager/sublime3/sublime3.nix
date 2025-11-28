{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sublime3
    sublime-merge
  ];

  home.file.".config/sublime-text-3/Packages/User/Adapta-Nokto.sublime-color-scheme".text = ''
    {
      "name": "Adapta Nokto",
      "globals": {
        "background": "#222D32",
        "foreground": "#ECEFF1",
        "caret": "#00BCD4",
        "line_highlight": "#37474F",
        "selection": "#37474F",
        "selection_border": "#00BCD4",
        "misspelling": "#FF5252",
        "accent": "#00BCD4"
      },
      "rules": [
        {
          "name": "Comment",
          "scope": "comment",
          "foreground": "#546E7A",
          "font_style": "italic"
        },
        {
          "name": "String",
          "scope": "string",
          "foreground": "#009688"
        },
        {
          "name": "Number",
          "scope": "constant.numeric",
          "foreground": "#C792EA"
        },
        {
          "name": "Keyword",
          "scope": "keyword",
          "foreground": "#C792EA"
        },
        {
          "name": "Function",
          "scope": "entity.name.function, support.function",
          "foreground": "#82B1FF"
        },
        {
          "name": "Class",
          "scope": "entity.name.class",
          "foreground": "#FFCB6B"
        },
        {
          "name": "Variable",
          "scope": "variable",
          "foreground": "#FF5252"
        },
        {
          "name": "Tag Name",
          "scope": "entity.name.tag",
          "foreground": "#FF5252"
        },
        {
          "name": "Attribute",
          "scope": "entity.other.attribute-name",
          "foreground": "#FFCB6B"
        }
      ]
    }
  '';
}

