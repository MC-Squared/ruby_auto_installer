module RubyAutoInstaller
  module Managers
    class Asdf
      def self.present?
        system("asdf --version")
      end

      def self.update
        `asdf update`
        `asdf plugin-update ruby`
      end

      def self.all_versions
        `asdf list-all ruby`.lines
      end

      def self.installed_versions
        `asdf list ruby`.lines
      end

      def self.install(version)
        system("asdf install ruby #{version}")
      end

      def self.refresh
      end
    end
  end
end
