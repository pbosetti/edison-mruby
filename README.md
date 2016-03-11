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

## Available gems

- [`pbosetti/mruby-hs-regexp`       ](http://github.com/pbosetti/mruby-hs-regexp       )
- [`pbosetti/mruby-io`              ](http://github.com/pbosetti/mruby-io              )
- [`pbosetti/mruby-dir`             ](http://github.com/pbosetti/mruby-dir             )
- [`pbosetti/mruby-tempfile`        ](http://github.com/pbosetti/mruby-tempfile        )
- [`pbosetti/mruby-yaml`            ](http://github.com/pbosetti/mruby-yaml            )
- [`pbosetti/mruby-merb`            ](http://github.com/pbosetti/mruby-merb            )
- [`pbosetti/mruby-serialport`      ](http://github.com/pbosetti/mruby-serialport      )
- [`pbosetti/mruby-shell`           ](http://github.com/pbosetti/mruby-shell           )
- [`pbosetti/mruby-mraa`            ](http://github.com/pbosetti/mruby-mraa            )
- [`iij/mruby-pack`                 ](http://github.com/iij/mruby-pack                 )
- [`iij/mruby-socket`               ](http://github.com/iij/mruby-socket               )
- [`iij/mruby-process`              ](http://github.com/iij/mruby-process              )
- [`iij/mruby-errno`                ](http://github.com/iij/mruby-errno                )
- [`ksss/mruby-signal`              ](http://github.com/ksss/mruby-signal              )
- [`UniTN-mechatronics/mruby-ftp`   ](http://github.com/UniTN-mechatronics/mruby-ftp   )
- [`UniTN-Mechatronics/mruby-fsm`   ](http://github.com/UniTN-Mechatronics/mruby-fsm   )
- [`UniTN-Mechatronics/mruby-gsl`   ](http://github.com/UniTN-Mechatronics/mruby-gsl   )
- [`UniTN-Mechatronics/mruby-mrubot`](http://github.com/UniTN-Mechatronics/mruby-mrubot)
- [`mattn/mruby-sinatic`            ](http://github.com/mattn/mruby-sinatic            )
- [`pbosetti/mruby-emb-require`     ](http://github.com/pbosetti/mruby-emb-require     )