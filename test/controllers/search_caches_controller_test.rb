require 'test_helper'

class SearchCachesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get search_caches_create_url
    assert_response :success
  end

end
