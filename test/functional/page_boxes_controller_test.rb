require 'test_helper'

class PageBoxesControllerTest < ActionController::TestCase
  setup do
    @page_box = page_boxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:page_boxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page_box" do
    assert_difference('PageBox.count') do
      post :create, :page_box => @page_box.attributes
    end

    assert_redirected_to page_box_path(assigns(:page_box))
  end

  test "should show page_box" do
    get :show, :id => @page_box.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @page_box.to_param
    assert_response :success
  end

  test "should update page_box" do
    put :update, :id => @page_box.to_param, :page_box => @page_box.attributes
    assert_redirected_to page_box_path(assigns(:page_box))
  end

  test "should destroy page_box" do
    assert_difference('PageBox.count', -1) do
      delete :destroy, :id => @page_box.to_param
    end

    assert_redirected_to page_boxes_path
  end
end
