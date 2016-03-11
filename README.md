# Build mruby for Intel Edison
This scripts simplifies the cross-compilation of mruby for Intel Edison.

Also look [here](https://gist.github.com/pbosetti/027125c4ba066f51bf2c) for more x-comp goodness ;)

## How to
Just install the [Intel's SDK](https://software.intel.com/en-us/iot/hardware/edison/downloads).

**NOTE**: the current version expects the SDK to be in `/opt/poky-edison/1.7.2`. If you have/need a different SDK version/location, remember to change `make.rb` accordingly.


### Easy path: just plain gems
In `make.rb` comment/remove any additional gem after the `conf.gembox 'default'`. Then just run `ruby make.rb`. The binaries wil be on `mruby/build/core2-32-poky-linux/[bin|lib]`. Copy them on your Edison and you are set.

Type `ruby make.rb clean` for cleanup. 

### More complete setup
The easy path is *easy*, but the resulting mruby lacks a lot of useful functionalities to be of some practical use.

The default version of `make.rb` is designed to also build a list of gems that are useful like file access, YAML support, GSL linear algebra support, and more.

Some of those, though, depend on external libraries that are not yet available on Edison's yocto repositories, and namely libyaml and libgsl. 

Consequently, before `run make.rb` you have to cross-compile and install some libraries. In particular, the following libraries are required:

- libYAML
- libUV
- libGSL

A detailed guide on how to proceed for cross compiling and installing these (and other) libraries is available [here in this gist](https://gist.github.com/pbosetti/027125c4ba066f51bf2c).



