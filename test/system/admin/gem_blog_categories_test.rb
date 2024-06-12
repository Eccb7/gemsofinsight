require "application_system_test_case"

class Admin::GemBlogCategoriesTest < ApplicationSystemTestCase
  setup do
    @admin_gem_blog_category = admin_gem_blog_categories(:one)
  end

  test "visiting the index" do
    visit admin_gem_blog_categories_url
    assert_selector "h1", text: "Gem blog categories"
  end

  test "should create gem blog category" do
    visit admin_gem_blog_categories_url
    click_on "New gem blog category"

    check "Active" if @admin_gem_blog_category.active
    fill_in "Description", with: @admin_gem_blog_category.description
    fill_in "Name", with: @admin_gem_blog_category.name
    click_on "Create Gem blog category"

    assert_text "Gem blog category was successfully created"
    click_on "Back"
  end

  test "should update Gem blog category" do
    visit admin_gem_blog_category_url(@admin_gem_blog_category)
    click_on "Edit this gem blog category", match: :first

    check "Active" if @admin_gem_blog_category.active
    fill_in "Description", with: @admin_gem_blog_category.description
    fill_in "Name", with: @admin_gem_blog_category.name
    click_on "Update Gem blog category"

    assert_text "Gem blog category was successfully updated"
    click_on "Back"
  end

  test "should destroy Gem blog category" do
    visit admin_gem_blog_category_url(@admin_gem_blog_category)
    click_on "Destroy this gem blog category", match: :first

    assert_text "Gem blog category was successfully destroyed"
  end
end
