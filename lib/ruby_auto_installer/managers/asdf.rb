module RubyAutoInstaller
  module Managers
    class Asdf
      def self.update
        `asdf update`
        `asdf plugin-update ruby`
      end

      def self.list_all_versions

      end

      def self.list_installed_versions

      end
    end
  end
end
