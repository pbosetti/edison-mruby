#!/usr/bin/env ruby

if __FILE__ == $PROGRAM_NAME then
  require 'fileutils'
  
  unless File.exists?('mruby')
    system 'git clone --depth 1 https://github.com/mruby/mruby.git'
  end
  
  unless system(%Q[cd mruby; MRUBY_CONFIG=#{File.expand_path __FILE__} ./minirake #{ARGV.join(' ')}])
    warn "Build error"
    exit -1
  end
    
  exit 0
end

MRuby::Build.new do |conf|
  toolchain :gcc
  conf.gembox 'default'
  #conf.gem File.dirname(__FILE__)
  conf.cc.defines = %w(ENABLE_READLINE)
  
  conf.gembox 'default'

  #lightweigh regular expression
  conf.gem :github => "pbosetti/mruby-hs-regexp", :branch => "master"
  
end

# Define cross build settings
MRuby::CrossBuild.new('core2-32-poky-linux') do |conf|
  toolchain :gcc

  # Path where require searches for libraries/gems:
  MRBGEMS_ROOT = "/usr/local/mrblib"

  # Mac OS X
  # get SDK from here: https://software.intel.com/en-us/iot/hardware/edison/downloads
  POKY_EDISON_PATH = '/opt/poky-edison/1.7.2'

  POKY_EDISON_SYSROOT =  "#{POKY_EDISON_PATH}/sysroots/core2-32-poky-linux"
  POKY_EDISON_X86_PATH = "#{POKY_EDISON_PATH}/sysroots/i386-pokysdk-darwin"
  POKY_EDISON_BIN_PATH = "#{POKY_EDISON_X86_PATH}/usr/bin/i586-poky-linux"

  conf.cc do |cc|
    cc.command = "#{POKY_EDISON_BIN_PATH}/i586-poky-linux-gcc"
    cc.include_paths << ["#{POKY_EDISON_SYSROOT}/usr/include", "#{POKY_EDISON_X86_PATH}/usr/include"]
    cc.flags = %w(-m32 -march=core2 -mtune=core2 -msse3 -mfpmath=sse -mstackrealign -fno-omit-frame-pointer)
    cc.flags << %w(-O2 -pipe -g -feliminate-unused-debug-types)
    cc.flags << "--sysroot=#{POKY_EDISON_SYSROOT}"
    cc.compile_options = "%{flags} -o %{outfile} -c %{infile}"
    cc.defines = %w(ENABLE_READLINE)
  end

  conf.cxx do |cxx|
    cxx.command = "#{POKY_EDISON_BIN_PATH}/i586-poky-linux-g++"
    cxx.include_paths = conf.cc.include_paths.dup
    cxx.include_paths << ["#{POKY_EDISON_SYSROOT}/usr/include/c++/4.9.1"]
    cxx.flags = conf.cc.flags.dup
    cxx.defines = conf.cc.defines.dup
    cxx.compile_options = conf.cc.compile_options.dup    
  end

  conf.archiver do |archiver|
    archiver.command = "#{POKY_EDISON_BIN_PATH}/i586-poky-linux-ar"
    archiver.archive_options = 'rcs %{outfile} %{objs}'
  end

  conf.linker do |linker|
    linker.command = "#{POKY_EDISON_BIN_PATH}/i586-poky-linux-g++"
    linker.flags = %w(-m32 -march=i586)
    linker.flags << "--sysroot=#{POKY_EDISON_SYSROOT}"
    linker.flags << %w(-O1)
    linker.libraries = %w(m pthread)
  end

  #do not build executable test
  conf.build_mrbtest_lib_only

  conf.gembox 'default'

  conf.gem 'mruby/mrbgems/mruby-hash-ext'
  conf.gem 'mruby/mrbgems/mruby-eval'
  conf.gem 'mruby/mrbgems/mruby-exit' # for exiting from within a script
  conf.gem 'mruby/mrbgems/mruby-string-ext'

  #lightweigh regular expression
  conf.gem :github => "pbosetti/mruby-hs-regexp", :branch => "master"
  conf.gem :github => 'pbosetti/mruby-io', :branch => "master"
  conf.gem :github => 'pbosetti/mruby-dir', :branch => "master"
  conf.gem :github => 'pbosetti/mruby-tempfile', :branch => "master"
  conf.gem :github => 'pbosetti/mruby-yaml', :branch => "master"
  conf.gem :github => 'pbosetti/mruby-merb', :branch => "master"
  conf.gem :github => 'pbosetti/mruby-serialport', :branch => 'master'
  conf.gem :github => 'pbosetti/mruby-shell', :branch => 'master'
  conf.gem :github => 'pbosetti/mruby-mraa', :branch => 'master'
  conf.gem :github => 'iij/mruby-pack', :branch => 'master'
  conf.gem :github => 'iij/mruby-socket', :branch => 'master'
  conf.gem :github => 'iij/mruby-process', :branch => 'master'
  conf.gem :github => 'iij/mruby-errno', :branch => 'master'
  conf.gem :github => 'ksss/mruby-signal', :branch => 'master'
  conf.gem :github => 'UniTN-mechatronics/mruby-ftp', :branch => 'master'
  conf.gem :github => 'UniTN-Mechatronics/mruby-fsm', :branch => 'master'
  conf.gem :github => 'UniTN-Mechatronics/mruby-gsl', :branch => "master"
  conf.gem :github => 'UniTN-Mechatronics/mruby-mrubot', :branch => "master"
  conf.gem :github => 'mattn/mruby-sinatic', :branch => 'master'
  
  # GEMS INCLUDED AFTER mruby-emb-require WILL BE COMPILED AS SEPARATE object
  # AND MUST BE LOADED AS require 'mruby-hs-regexp'
  conf.gem :github => 'pbosetti/mruby-emb-require', :branch => "master"
  if g = conf.gems.find {|e| e.name.match /mruby-require/} then
    g.build.cc.flags << "-DMRBGEMS_ROOT=\\\"#{MRBGEMS_ROOT}\\\""
  end

end
