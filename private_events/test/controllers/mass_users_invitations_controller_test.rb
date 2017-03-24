require 'test_helper'

class MassUsersInvitationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get mass_users_invitations_create_url
    assert_response :success
  end

end
