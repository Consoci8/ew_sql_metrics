module EwSqlMetrics
  class Metric
    include MongoMapper::Document

    key :name, String
    key :duration, Integer
    key :instrumenter_id, String
    key :payload, Hash
    key :started_at, Time
    key :created_at, Time

    def self.store!(args)
      metric = new
      metric.parse(args)
      metric.save!
    end

    def parse(args)
      self.name            = args[0]
      self.started_at      = args[1]
      self.duration        = (args[2] - args[1]) * 1000000
      self.instrumenter_id = args[3]
      self.payload         = args[4]
      self.created_at      = Time.now.utc
    end
  end
end