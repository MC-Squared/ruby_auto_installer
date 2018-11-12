require "thor"

module RubyAutoInstaller
  class CLI < Thor
    desc "update", "install new ruby versions using a version manager"
    method_option :manager_name, aliases: "-n", desc: "Manager to use (asdf/rbenv/rvm)"
    method_option :verbose, aliases: "-v", desc: "Verbose output"
    method_option :greedy, aliases: "-g", desc: "Install all versions, not just latest patch"
    method_option :min_version, aliases: "-m", desc: "Minimum Ruby version to consider (i.e.\"2.0\")"
    method_option :dry_run, aliases: "-d", desc: "List versions that would be installed, but do not install"
    def update
      @verbose = options[:verbose]
      manager_name = options[:manager_name]

      if options[:manager_name].nil?
        debug "Finding manager..."
        if Managers::Asdf.present?
          debug "Found asdf version manager"
          manager_name = "asdf"
        elsif Managers::Rbenv.present?
          debug "Found rbenv version manager"
          manager_name = "rbenv"
        elsif Managers::Rvm.present?
          debug "Found rvm version manager"
          manager_name = "rvm"
        else
          raise "Failed to find a version manager"
        end
      end

      debug "Attempting to use #{manager_name} version manager"
      manager = load_manager(manager_name)

      debug "Updating #{manager_name}"
      manager.update

      debug "Currently installed versions:"
      installed = strip_lines(manager.installed_versions)
      debug installed

      debug "Available versions:"
      available = strip_lines(standard_releases_only(manager.all_versions))
      debug available

      if options[:greedy].nil?
        latest = []
        available.sort_by! { |version| Gem::Version.new(version) }
        loop do
          last = available.last
          latest << last

          available.reject! { |version| version[0..2] == last[0..2] }
          break if available.empty?
        end
        available = latest
      end

      debug "Versions to be installed:"
      install_versions = missing_releases(installed, available)

      unless options[:min_version].nil?
        install_versions.reject! { |version| version <= options[:min_version] }
      end

      debug install_versions

      install_versions.each do |version|
        if options[:dry_run]
          puts "DRY RUN: Would install #{version}"
        else
          manager.install(version)
        end
      end

      manager.refresh

      puts "All done!"
    end

    private

    def standard_releases_only(versions)
      versions.select { |line| line.match("^[0-9]*.[0-9]*.[0-9]*$") }
    end

    def missing_releases(installed, available)
      available.reject { |version| installed.include? version }
    end

    def strip_lines(str)
      str.map(&:strip)
    end

    def load_manager(name)
      manager = "RubyAutoInstaller::Managers::#{name.capitalize}".
                  split("::").
                  inject(Object) { |o, c| o.const_get c }

      unless manager.present?
        raise "Failed to load manager #{name}"
      end

      manager
    end

    def debug(msg)
      puts msg if @verbose
    end
  end
end
