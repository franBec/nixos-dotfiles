{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/github_ed25519";
        forwardAgent = false;
      };
    };
  };
}
