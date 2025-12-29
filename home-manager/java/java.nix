{ pkgs, pkgs-unstable, ... }:
{
  home.packages = [
    pkgs-unstable.javaPackages.compiler.openjdk25
    pkgs-unstable.gradle_9
  ];

  home.sessionVariables = {
    JAVA_HOME = "${pkgs-unstable.javaPackages.compiler.openjdk25}/lib/openjdk";
  };
}