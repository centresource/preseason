# config/schedule.rb for whenever cron tab
create_file 'config/schedule.rb', <<-CRONTAB
# Use this file to easily define all of your cron jobs.

every :sunday, :at => '4am' do
  rake "log:clear"
end

# Learn more: http://github.com/javan/whenever
CRONTAB