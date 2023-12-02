{
  description = "Core Nix Library - depends only on `builtins`";

  outputs = { self }: {
    type = "pureNixLib";
    core = import ./core.nix;
  };
}
