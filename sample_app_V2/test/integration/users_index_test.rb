require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:archer)
		@user2 = users(:michael)
		@user3 = users(:saber)
		@user4 = users(:malory)
		@non_activated = users(:non_activated)

		@admin = users(:michael)
	end

	test "should redirect from index to login_url when not logged in" do
		get users_path
		assert_redirected_to login_url
	end

	test "should show the proper index webpage when logged in" do
		log_in_as(@user)
		get users_path
  	
		assert_select 'ul.users' do |user| 
			assert_select user, 'li', count: 30		
			assert_select user, 'a[href=?]', user_path(@user), count: 1
			assert_select user, 'a[href=?]', user_path(@user2), count: 1
			assert_select user, 'a[href=?]', user_path(@user3), count: 1
			assert_select user, 'a[href=?]', user_path(@user4), count: 1			
		end
	end

	test "index including pagination" do
		log_in_as(@user)
		get users_path
		assert_template 'users/index' 
		assert_select 'div.pagination',count: 2

		User.paginate(page: 1).each do |user|
			assert_select 'a[href=?]', user_path(user), text: user.name
		end
	end


	test "should only show delete links to admins" do
		log_in_as(@admin)
		get users_path
		assert_template 'users/index'
		assert_select 'div.pagination'
		User.paginate(page: 1).each do |user| #make sure there are delete buttons
			unless user == @admin
				assert_select 'a[href=?]', user_path(user), text: 'delete'
			end
		end
		assert_difference 'User.count', -1 do
			delete user_path(@user)
		end

	end

	test "index as non-admin" do 
		log_in_as(@user)
		get users_path
		assert_select 'a', text: 'delete', count: 0

		assert_no_difference 'User.count' do
			delete user_path(@user3)
		end
	end



end
