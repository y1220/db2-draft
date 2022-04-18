require "test_helper"

class OptionalProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get optional_products_index_url
    assert_response :success
  end
end
