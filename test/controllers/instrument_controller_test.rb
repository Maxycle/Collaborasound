require "test_helper"

class InstrumentControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get instrument_index_url
    assert_response :success
  end

  test "should get show" do
    get instrument_show_url
    assert_response :success
  end

  test "should get new" do
    get instrument_new_url
    assert_response :success
  end

  test "should get create" do
    get instrument_create_url
    assert_response :success
  end

  test "should get edit" do
    get instrument_edit_url
    assert_response :success
  end

  test "should get update" do
    get instrument_update_url
    assert_response :success
  end

  test "should get destroy" do
    get instrument_destroy_url
    assert_response :success
  end
end
