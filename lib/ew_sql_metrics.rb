require "mongo_mapper"
require "ew_sql_metrics/engine"

# We are required to choose a database name
MongoMapper.database = "ew_sql_metrics-#{Rails.env}"

require "active_support/notifications"
ActiveSupport::Notifications.subscribe /^sql\./ do |*args|
  EwSqlMetrics::Metric.store!(args)
end