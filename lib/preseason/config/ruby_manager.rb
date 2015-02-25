class Preseason
  module Config
    class RubyManager
      include Config

      attr_accessor :ruby_manager

      def ask_user
        self.ruby_manager ||= ask "What ruby manager will you be using?", :limited_to => managers.keys
        if rvm? && !rvm_installed?
          raise "You must install rvm in order to use it as a manager! Please visit www.rvm.io."
        end
      end

      def rvm?
        ruby_manager == 'rvm'
      end

      def rbenv?
        ruby_manager == 'rbenv'
      end

      def manager_name
        managers[ruby_manager]
      end

      private

      def managers
        { 'rvm' => 'rvm', 'rbenv' => 'rbenv' }
      end

      def rvm_installed?
        File.exist?("#{ENV['HOME']}/.rvm/scripts/rvm") || File.exist?("/usr/local/rvm/scripts/rvm")
      end
    end
  end
end
