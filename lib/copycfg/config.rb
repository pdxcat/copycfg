# Copycfg::Config
# Computer Action Team
# Maseeh College of Engineering and Computer Science
#
# This provides a singleton class to manage the copycfg configuration data.
# Has things like helpers for specific configuration classes

require "yaml"

module Copycfg::Config

  class << self

    # Configuration from YAML
    attr_reader :config

    # Loads configuration
    def loadconfig yamlfile
      File.open(yamlfile) { | yf | @config = YAML::load yf }
    end

    # Creates a lists of files to copy for a host.
    # This moves the burden of processing yaml from the host to the config
    def filelist host
      files = @config["hosts"][host]["files"]

      @config["hosts"][host]["filegroups"].each do | group |
        files += @config["filegroups"][group]
      end

      if files.empty?
        files += @config["filegroups"]["default"]
      end
    end

    # Gives direct access to the yaml structure
    # In essence, Copycfg::Config["val"] vs Copycfg::Config.config["val"]
    def [](name)
      @config[name]
    end
  end
end
