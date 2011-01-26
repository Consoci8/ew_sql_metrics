require "active_support/notifications"
require "mongoid"
require "ew_sql_metrics/engine"
require "ew_sql_metrics/mute_middleware"
require "thread"

# We are required to choose a database name
Mongoid.configure do |config|
  name = "ew_sql_metrics-#{Rails.env}"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
  config.persist_in_safe_mode = false
end


module EwSqlMetrics
  def self.queue
    @queue ||= Queue.new
  end

  def self.thread
    @thread ||= Thread.new do
      while args = queue.pop
        EwSqlMetrics::Metric.store!(args)
      end
    end
  end
end

# Start the Queue and Thread
EwSqlMetrics.queue
EwSqlMetrics.thread

ActiveSupport::Notifications.subscribe /^sql\./ do |*args|
  EwSqlMetrics.queue << args unless EwSqlMetrics.mute?
end

module EwSqlMetrics
  def self.finish!
    queue << nil
    thread.join
    @thread = nil
    thread
  end
end