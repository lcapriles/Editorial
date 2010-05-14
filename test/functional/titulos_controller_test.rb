require 'test_helper'

class TitulosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:titulos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create titulo" do
    assert_difference('Titulo.count') do
      post :create, :titulo => { }
    end

    assert_redirected_to titulo_path(assigns(:titulo))
  end

  test "should show titulo" do
    get :show, :id => titulos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => titulos(:one).to_param
    assert_response :success
  end

  test "should update titulo" do
    put :update, :id => titulos(:one).to_param, :titulo => { }
    assert_redirected_to titulo_path(assigns(:titulo))
  end

  test "should destroy titulo" do
    assert_difference('Titulo.count', -1) do
      delete :destroy, :id => titulos(:one).to_param
    end

    assert_redirected_to titulos_path
  end
end
