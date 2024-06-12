require "test_helper"

class Admin::GemBlogCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_gem_blog_category = admin_gem_blog_categories(:one)
  end

  test "should get index" do
    get admin_gem_blog_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_gem_blog_category_url
    assert_response :success
  end

  test "should create admin_gem_blog_category" do
    assert_difference("Admin::GemBlogCategory.count") do
      post admin_gem_blog_categories_url, params: { admin_gem_blog_category: { active: @admin_gem_blog_category.active, description: @admin_gem_blog_category.description, name: @admin_gem_blog_category.name } }
    end

    assert_redirected_to admin_gem_blog_category_url(Admin::GemBlogCategory.last)
  end

  test "should show admin_gem_blog_category" do
    get admin_gem_blog_category_url(@admin_gem_blog_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_gem_blog_category_url(@admin_gem_blog_category)
    assert_response :success
  end

  test "should update admin_gem_blog_category" do
    patch admin_gem_blog_category_url(@admin_gem_blog_category), params: { admin_gem_blog_category: { active: @admin_gem_blog_category.active, description: @admin_gem_blog_category.description, name: @admin_gem_blog_category.name } }
    assert_redirected_to admin_gem_blog_category_url(@admin_gem_blog_category)
  end

  test "should destroy admin_gem_blog_category" do
    assert_difference("Admin::GemBlogCategory.count", -1) do
      delete admin_gem_blog_category_url(@admin_gem_blog_category)
    end

    assert_redirected_to admin_gem_blog_categories_url
  end
end
