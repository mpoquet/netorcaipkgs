netorcaipkgs
============

This repository contains the definition of [Nix] packages related to [netorcai].

Usage
-----
Install [Nix] on your machine then install packages thanks to ``nix-env --install`` (``-i``).

For example, you can install the [netorcai orchestrator] with one of the following lines.
``` bash
# Install latest release.
nix-env -f https://github.com/netorcai/pkgs/archive/master.tar.gz -iA netorcai

# Install dev version (master branch latest commit).
nix-env -f https://github.com/netorcai/pkgs/archive/master.tar.gz -iA netorcai
```

Please read [./default.nix] to have a list of all the available packages
(understanding all of this file requires knowledge in the [Nix language],
but listing the packages should not).

Customizing packages
--------------------
Most packages have input parameters that can be tuned.
For example, the package of the [C++ version of the netorcai client library]
defines the ``doTests`` and ``doCodeDoc`` options.

You can set these options with the ``--arg`` command-line argument of ``nix-env`` and ``nix-build``.

``` bash
# Build the latest release of the C++ client library with tests and doxygen doc.
# Note 1: Result will be put in ./result
# Note 2: You can use netorcai_client_cpp_dev to use latest master commit instead.
nix-build https://github.com/netorcai/pkgs/archive/master.tar.gz \
    -A netorcai_client_cpp \
    --arg doTests true \
    --arg doCodeDoc true

# Install the latest commit of the C++ client library but only if tests pass.
# Note 1: Make sure that your PATH environment variable contains
          ${HOME}/.nix-profile/bin if you want to install executable binaries.
# Note 2: Make sure that your PKG_CONFIG_PATH environment variable contains
          ${HOME}/.nix-profile/lib/pkgconfig if you want to install libraries.
nix-env -f https://github.com/netorcai/pkgs/archive/master.tar.gz \
    -iA netorcai_client_cpp_dev \
    --arg doTests true \
    --arg doCodeDoc false
```

Please read the definition of each package for a list of the available options.
Such input parameters should have a default value visible thanks to the ``?`` operator.
Search ``doTests`` and ``doCodeDoc`` in [./netorcai-client-cpp/default.nix]
for a syntax example.

[Nix]: https://nixos.org/nix/
[Nix language]: https://nixos.org/nix/manual/#ch-expression-language

[netorcai]: https://github.com/netorcai/
[netorcai orchestrator]: https://github.com/netorcai/netorcai
[C++ version of the netorcai client library]: https://github.com/netorcai/netorcai-client-cpp

[./default.nix]: ./default.nix
[./netorcai-client-cpp/default.nix]: ./netorcai-client-cpp/default.nix
