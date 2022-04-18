require "test_helper"

class ProductPackagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get product_packages_index_url
    assert_response :success
  end
end
