require 'test_helper'

class TymlsControllerTest < ActionController::TestCase
  setup do
    @tyml = tymls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tymls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tyml" do
    assert_difference('Tyml.count') do
      post :create, tyml: { note: @tyml.note, receiver_id: @tyml.receiver_id, sender_id: @tyml.sender_id, url: @tyml.url, viewed: @tyml.viewed }
    end

    assert_redirected_to tyml_path(assigns(:tyml))
  end

  test "should show tyml" do
    get :show, id: @tyml
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tyml
    assert_response :success
  end

  test "should update tyml" do
    put :update, id: @tyml, tyml: { note: @tyml.note, receiver_id: @tyml.receiver_id, sender_id: @tyml.sender_id, url: @tyml.url, viewed: @tyml.viewed }
    assert_redirected_to tyml_path(assigns(:tyml))
  end

  test "should destroy tyml" do
    assert_difference('Tyml.count', -1) do
      delete :destroy, id: @tyml
    end

    assert_redirected_to tymls_path
  end
end
