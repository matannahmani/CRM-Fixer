require 'test_helper'

class HelpOptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @help_option = help_options(:one)
  end

  test "should get index" do
    get help_options_url
    assert_response :success
  end

  test "should get new" do
    get new_help_option_url
    assert_response :success
  end

  test "should create help_option" do
    assert_difference('HelpOption.count') do
      post help_options_url, params: { help_option: { descriptioncall: @help_option.descriptioncall, descriptionvol: @help_option.descriptionvol } }
    end

    assert_redirected_to help_option_url(HelpOption.last)
  end

  test "should show help_option" do
    get help_option_url(@help_option)
    assert_response :success
  end

  test "should get edit" do
    get edit_help_option_url(@help_option)
    assert_response :success
  end

  test "should update help_option" do
    patch help_option_url(@help_option), params: { help_option: { descriptioncall: @help_option.descriptioncall, descriptionvol: @help_option.descriptionvol } }
    assert_redirected_to help_option_url(@help_option)
  end

  test "should destroy help_option" do
    assert_difference('HelpOption.count', -1) do
      delete help_option_url(@help_option)
    end

    assert_redirected_to help_options_url
  end
end
