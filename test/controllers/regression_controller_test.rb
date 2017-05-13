require 'test_helper'

class RegressionControllerTest < ActionDispatch::IntegrationTest
  test "should get logistic_regression" do
    get regression_logistic_regression_url
    assert_response :success
  end

end
