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
      "ssh.dev.azure.com" = {
        user = "git";
        identityFile = "~/.ssh/azuredevops_rsa";
        forwardAgent = false;
      };
    };
  };
}
