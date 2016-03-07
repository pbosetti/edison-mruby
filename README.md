# Build mruby for Intel Edison

This scripts simplifies the cross-compilation of mruby for Intel Edison.

Also look [here](https://gist.github.com/pbosetti/027125c4ba066f51bf2c) for more x-comp goodness ;)

## How to

Just install the [Intel's SDK](https://software.intel.com/en-us/iot/hardware/edison/downloads) and run `ruby make.rb`. The binaries wil be on `mruby/build/core2-32-poky-linux/[bin|lib]`.

Edit the gem list to taste in `make.rb`.

**NOTE**: the current version expects the SDK to be in `/opt/poky-edison/1.7.2`. If you have/need a different SDK version/location, remember to change `make.rb` accordingly.

Type `ruby make.rb clean` for cleanup. 