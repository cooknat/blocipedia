require 'test_helper'

class CollaboratorsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get collaborators_new_url
    assert_response :success
  end

end
