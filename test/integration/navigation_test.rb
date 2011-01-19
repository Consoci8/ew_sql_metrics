require 'test_helper'

class NavigationTest < ActiveSupport::IntegrationCase
  test "can visualize and delete notifications created in request" do
    visit new_user_path 
    fill_in "Name", :with => "John Doe"
    fill_in "Age", :with => "23"
    click_button "Create User"
    
    # Check for metrics data on the page
    visit sql_metrics_path
    assert_match "User Load", page.body
    assert_match "INSERT INTO", page.body
    assert_match "John Doe", page.body
    assert_match "sql.active_record", page.body
    
    # Assert the number of rows change when an item is delete
    assert_difference "all('table tr').count", -1 do
      click_link "Destroy"
    end
  end
  
  test "I can see will paginate links" do 
    # will paginate defaults to 30 per page
    31.times do | this|
      visit new_user_path 
      fill_in "Name", :with => "John Doe"
      fill_in "Age", :with => "23"
      click_button "Create User"
    end
    
    visit sql_metrics_path
    assert_match "Next", page.body
  end
end
