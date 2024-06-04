require "test_helper"

class Public::CommunitymembersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_communitymembers_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_communitymembers_destroy_url
    assert_response :success
  end
end
