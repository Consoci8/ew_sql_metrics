require 'test_helper'

class NavigationTest < ActiveSupport::IntegrationCase
  test 'can ignore notifications for a given path' do
  
    begin
      EwSqlMetrics.mute_regexp = %r{^/users}

      assert_no_difference "EwSqlMetrics::Metric.count" do
        visit "/users"
      end
    ensure
      EwSqlMetrics.mute_regexp = nil
    end
  end
  
  
  test "can visualize and delete notifications created in request" do
    do_login
  
    visit new_post_path 
    fill_in "Title", :with => "Heyheyhey"
    fill_in "Body", :with => "The Body"
    click_button "Create Post"
    EwSqlMetrics.finish!
    
    # Check for metrics data on the page
    visit sql_metrics_path
    assert_match "testmail@mail.com", page.body
    assert_match "User Load", page.body
    assert_match "INSERT INTO", page.body
    assert_match "Heyheyhey", page.body
    assert_match "sql.active_record", page.body
    
  end
  
  
  test "I can see will paginate links" do 
    do_login
    
    # will paginate defaults to 30 per page
    31.times do | this|
      visit new_user_path 
      fill_in "Name", :with => "John Doe"
      fill_in "Age", :with => "23"
      click_button "Create User"
    end
    EwSqlMetrics.finish!
    
    visit sql_metrics_path
    assert_match "Next", page.body
  end
  
  private

  
  def do_login
     user = User.create(:email => "testmail@mail.com", :password => "password123", :password_confirmation => "password123")
     visit new_user_session_path
     fill_in "Email",  :with => user.email
     fill_in "Password", :with => user.password
     click_button "Sign in"
  end
  
end
