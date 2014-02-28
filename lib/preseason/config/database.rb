class Preseason
  module Config
    class Database
      include Config

      attr_accessor :database, :password
      attr_reader :username

      def ask_user
        self.database ||= ask "What db will you be using?", :limited_to => gems.keys

        unless database == 'sqlite'
          self.username = ask "What is your #{database} database username? (leave blank for `whoami`)"
          self.password = ask "What is your #{database} database password? (leave blank for none)"
        end
      end

      def username=(other)
        @username = other.blank? ? (`whoami`).chomp : other
      end

      def postgres?
        database == 'postgres'
      end

      def sqlite?
        database == 'sqlite'
      end

      def adapter_name
        adapters[database]
      end

      def gem_name
        gems[database]
      end

      private
      def adapters
        { 'postgres' => 'postgresql', 'mysql' => 'mysql2', 'sqlite' => 'sqlite3' }
      end

      def gems
        { 'postgres' => 'pg', 'mysql' => 'mysql2', 'sqlite' => 'sqlite3' }
      end
    end
  end
end
