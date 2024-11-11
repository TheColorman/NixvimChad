# NixvimChad - the NvChad config for NixVim

NixvimChad is a Neovim distribution built using [NixVim](https://github.com/nix-community/nixvim), designed to mimic [NvChad](https://nvchad.com) as closely as possible.

![nvimchad.png](./assets/nixvimchad.png)

> [!WARNING]
> NixvimChad depends on features not currently present in upstream NixVim. The flake inputs for NixvimChad are therefore pointed to [my own fork of NixVim](https://github.com/thecolorman/nixvim). The input will be changed once upstream has the required features (see [the fork diff](https://github.com/nix-community/nixvim/compare/main...TheColorman:nixvim:main) for the features NixvimChad requires).

> [!IMPORTANT]
> NixvimChad is developed for my own personal use, so I can't guarantee quality or that everything will work properly. For example, some NvChad plugins rely on hardcoded paths to `~/.local/share/nvim/lazy/`, as they would ordinarily be installed there, instead of the Nix store. Whenever I run intro a problem I try to fix it, and if you open an issue I'll probably take a look at that too, but you should expect there to be bugs.

## Try

You can try out NixvimChad with the following command:

```bash
nix run github:thecolorman/nixvimchad
# or edit a file
nix run github:thecolorman/nixvimchad -- file.nix
```

## Why?

NvChad is a great set of default plugins for Neovim that turns the editor into an IDE. At the same time, NvChad (and Vim in a broader sense) relies on mutable configuration in your home directory, which goes against the immutable and declarative philosophy of Nix. NixVim was created to address this, being a Neovim distribution entirely designed around configuring Neovim using the Nix language.

NvChad is a very popular starting point for Neovim configurations, but getting it to work in NixVim is a pain due to the differing configuration philosophies. That's where NixvimChad comes in!

## How?

NixvimChad emulates every step of a normal NvChad configuration by manually converting NvChad's Lua code into a NixVim configuration. The entire program flow of the default NvChad configuration has been tirelessly converted to equivalent NixVim code, even making use of [lazy.nvim](https://lazy.folke.io/) for lazy-loading and bytecode compilation!

## Extending

You can use NixvimChad as the base for your own NixVim config by using the exposed `configure` helper. NixvimChad adds new options to the NixVim configuratoin under the `chad` option.

> [!NOTE]
> `configure` is just a wrapper over NixVim's [`<nixvim>.extend`](https://nix-community.github.io/nixvim/platforms/standalone.html?highlight=extend#extending-an-existing-configuration) function. `configure` creates a package for each supported system, where `<nixvim>.extend` only extends a single package.

Nix flake template:

```nix
{
  inputs = {
    nixvimchad.url = "github:thecolorman/nixvimchad";
  };

  outputs = {nixvimchad, ...}:
    nixvimchad.configure (import ./config);
};
```

The `configure` function will generate the proper `package` attributes for your flake. You can then write your NixVim config like normal:  

```nix
# config/default.nix
{ pkgs, ... }: {
  extraConfigLua = ''
    -- your lua config here
  '';
}
```

In addition, NixvimChad exposes new options under `chad` that allow you to disable or override the configuration to any of the plugins used in NvChad:

```nix
# config/default.nix
{ pkgs, ... }: {
  chad.plugins.lspconfig.pluginConfig = {
    # You can put anything in here that is defined at https://nix-community.github.io/nixvim/plugins/lazy/plugins.html
    config = ''
      function()
        require("nvchad.configs.lspconfig").defaults()

        local lspconfig = require "lspconfig"

        local servers = { "nixd" }
        local nvlsp = require "nvchad.configs.lspconfig"

        for _, lsp in ipairs(servers) do
          lspconfig[lsp].setup {
            on_attach = nvlsp.on_attach,
            on_init = nvlsp.on_init,
            capabilities = nvlsp.capabilities,
          }
        end
      end
    '';
  };
}
```

You can then run your configuration with `nix run` or add it as an input in your NixOS system flake to add the executable to your NixOS configuration:

```nix
# system flake
{
  inputs.nixvimcfg.url = "github:<your_name>/<your_repository>";
  
  outputs = {nixvimcfg, ...}: {
    nixosConfigurations = {
      hostname = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          {
            environment.systemPackages = [ nixvimcfg.packages.x86_64-linux.default ];
          }
        ];
      };
    };
  };
}
```
