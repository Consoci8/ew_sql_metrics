module EwSqlMetrics
  class Metric
    include Mongoid::Document
    
    field :name, :type => String
    field :duration, :type => Integer
    field :instrumenter_id, :type => String
    field :payload, :type => Hash
    field :started_at, :type => Time
    field :created_at, :type => Time
    field :user_id, :type => Integer
    field :user_email, :type => String
    
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
      self.user_id         = args[5]
      self.user_email      = args[6]
    end
  end
end