# set up flash messages
empty_directory 'app/views/shared'
create_file 'app/views/shared/_flash.html.erb', <<-FLASH
<% flash().each do |key, msg| %>
  <div class="alert alert-<%= key %> fade in">
    <%= link_to '&times;'.html_safe, '#', :class => 'close', 'data-dismiss' => 'alert' %>
    <%= msg %>
  </div>
<% end %>
FLASH
insert_into_file 'app/views/layouts/application.html.erb', "\n  <%= render 'shared/flash' %>", :after => "<body>\n"
