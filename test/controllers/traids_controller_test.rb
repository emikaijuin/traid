require 'test_helper'

class TraidsControllerTest < ActionController::TestCase
  setup do
    @traid = traids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:traids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create traid" do
    assert_difference('Traid.count') do
      post :create, traid: {  }
    end

    assert_redirected_to traid_path(assigns(:traid))
  end

  test "should show traid" do
    get :show, id: @traid
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @traid
    assert_response :success
  end

  test "should update traid" do
    patch :update, id: @traid, traid: {  }
    assert_redirected_to traid_path(assigns(:traid))
  end

  test "should destroy traid" do
    assert_difference('Traid.count', -1) do
      delete :destroy, id: @traid
    end

    assert_redirected_to traids_path
  end
end
