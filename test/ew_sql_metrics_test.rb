require 'test_helper'

class EwSqlMetricsTest < ActiveSupport::TestCase
  test "any sql. notification is saved in the mongo database" do
    payload = { "sql" => "SELECT * FROM foo" }

    ActiveSupport::Notifications.instrument "sql.any_orm", payload do
      sleep(0.001) # sleep for 1000 microseconds
    end
    
    EwSqlMetrics.finish!

    metric = EwSqlMetrics::Metric.first
    assert_equal 1, EwSqlMetrics::Metric.count
    assert_equal "sql.any_orm", metric.name
    assert_equal payload, metric.payload

    assert metric.duration
    assert metric.instrumenter_id
    assert metric.started_at
    assert metric.created_at
  end
  
  test 'can ignore notifications when specified' do
    EwSqlMetrics.mute! do
      assert EwSqlMetrics.mute?

      ActiveSupport::Notifications.instrument "sql.any_orm" do
        sleep(0.001) # sleep for 1000 microseconds
      end
      
      EwSqlMetrics.finish!
    end

    assert !EwSqlMetrics.mute?
    assert_equal 0, EwSqlMetrics::Metric.count
  end
end
