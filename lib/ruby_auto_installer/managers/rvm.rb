module RubyAutoInstaller
  module Managers
    class Rvm
      def self.present?
        system("rvm --version")
      end

      def self.update
        `rvm get stable`
        `rvm reload`
      end

      def self.all_versions
        `rvm list --all`.lines
      end

      def self.installed_versions
        `rvm list`.lines
      end

      def self.install(version)
        system("rvm install #{version}")
      end

      def self.refresh
      end
    end
  end
end
