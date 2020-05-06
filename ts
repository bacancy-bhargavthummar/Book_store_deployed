<h2>Edit <%= resource_name.to_s.humanize %></h2>

config.time_zone = 'Kolkata'
config.active_record.default_timezone = :local

$(".my_comment_form").trigger('reset');

include ActiveSupport::LoggerSilence if defined?(ActiveSupport::LoggerSilence)