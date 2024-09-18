require "application_system_test_case"

class AppsTest < ApplicationSystemTestCase
  setup do
    @jia_bo_panel_app = jia_bo_panel_apps(:one)
  end

  test "visiting the index" do
    visit jia_bo_panel_apps_url
    assert_selector "h1", text: "Apps"
  end

  test "should create App" do
    visit jia_bo_panel_apps_url
    click_on "New App"

    fill_in "Api key", with: @jia_bo_panel_app.api_key
    fill_in "Member code", with: @jia_bo_panel_app.member_code
    click_on "Create App"

    assert_text "App was successfully created"
    click_on "Back"
  end

  test "should update App" do
    visit jia_bo_panel_apps_url
    click_on "Edit", match: :first

    fill_in "Api key", with: @jia_bo_panel_app.api_key
    fill_in "Member code", with: @jia_bo_panel_app.member_code
    click_on "Update App"

    assert_text "App was successfully updated"
    click_on "Back"
  end

  test "should destroy App" do
    visit jia_bo_panel_apps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "App was successfully destroyed"
  end
end
