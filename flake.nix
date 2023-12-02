{
  description = "Core Nix Library - depends only on `builtins`";

  outputs = { self }: {
    type = "pureNixLib";
    value = import ./core.nix;
  };
}
