require "application_system_test_case"

class TemplatesTest < ApplicationSystemTestCase
  setup do
    @jia_bo_panel_template = jia_bo_panel_templates(:one)
  end

  test "visiting the index" do
    visit jia_bo_panel_templates_url
    assert_selector "h1", text: "Templates"
  end

  test "should create Template" do
    visit jia_bo_panel_templates_url
    click_on "New Template"

    fill_in "Code", with: @jia_bo_panel_template.code
    fill_in "Title", with: @jia_bo_panel_template.title
    click_on "Create Template"

    assert_text "Template was successfully created"
    click_on "Back"
  end

  test "should update Template" do
    visit jia_bo_panel_templates_url
    click_on "Edit", match: :first

    fill_in "Code", with: @jia_bo_panel_template.code
    fill_in "Title", with: @jia_bo_panel_template.title
    click_on "Update Template"

    assert_text "Template was successfully updated"
    click_on "Back"
  end

  test "should destroy Template" do
    visit jia_bo_panel_templates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Template was successfully destroyed"
  end
end
