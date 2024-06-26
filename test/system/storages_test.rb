require "application_system_test_case"

class StoragesTest < ApplicationSystemTestCase
  setup do
    @storage = storages(:one)
  end

  test "visiting the index" do
    visit storages_url
    assert_selector "h1", text: "Storages"
  end

  test "should create storage" do
    visit storages_url
    click_on "New storage"

    fill_in "Category", with: @storage.category_id
    fill_in "Description", with: @storage.description
    fill_in "Image data", with: @storage.image_data
    fill_in "Name", with: @storage.name
    fill_in "User", with: @storage.user_id
    click_on "Create Storage"

    assert_text "Storage was successfully created"
    click_on "Back"
  end

  test "should update Storage" do
    visit storage_url(@storage)
    click_on "Edit this storage", match: :first

    fill_in "Category", with: @storage.category_id
    fill_in "Description", with: @storage.description
    fill_in "Image data", with: @storage.image_data
    fill_in "Name", with: @storage.name
    fill_in "User", with: @storage.user_id
    click_on "Update Storage"

    assert_text "Storage was successfully updated"
    click_on "Back"
  end

  test "should destroy Storage" do
    visit storage_url(@storage)
    click_on "Destroy this storage", match: :first

    assert_text "Storage was successfully destroyed"
  end
end
