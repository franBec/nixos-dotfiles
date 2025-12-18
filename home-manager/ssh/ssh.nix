{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        forwardAgent = false;
        forwardX11 = false;
        forwardX11Trusted = false;
        identitiesOnly = false;
        sendEnv = [ "LANG" "LC_*" ];
      };
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
