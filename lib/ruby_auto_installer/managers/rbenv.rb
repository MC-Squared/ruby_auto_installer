module RubyAutoInstaller
  module Managers
    class Rbenv
      def self.present?
        system("rbenv version")
      end

      def self.update
        # Not yet implemented
      end

      def self.all_versions
        `rbenv install -l`.lines
      end

      def self.installed_versions
        `rbenv versions`.lines
      end

      def self.install(version)
        system("rbenv install ruby #{version}")
      end

      def self.refresh
        system("rbenv rehash")
      end
    end
  end
end
