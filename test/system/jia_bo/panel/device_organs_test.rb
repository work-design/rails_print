require "application_system_test_case"

class DeviceOrgansTest < ApplicationSystemTestCase
  setup do
    @jia_bo_panel_device_organ = jia_bo_panel_device_organs(:one)
  end

  test "visiting the index" do
    visit jia_bo_panel_device_organs_url
    assert_selector "h1", text: "Device organs"
  end

  test "should create device organ" do
    visit jia_bo_panel_device_organs_url
    click_on "New device organ"

    fill_in "Default", with: @jia_bo_panel_device_organ.default
    fill_in "Organ", with: @jia_bo_panel_device_organ.organ_id
    click_on "Create Device organ"

    assert_text "Device organ was successfully created"
    click_on "Back"
  end

  test "should update Device organ" do
    visit jia_bo_panel_device_organ_url(@jia_bo_panel_device_organ)
    click_on "Edit this device organ", match: :first

    fill_in "Default", with: @jia_bo_panel_device_organ.default
    fill_in "Organ", with: @jia_bo_panel_device_organ.organ_id
    click_on "Update Device organ"

    assert_text "Device organ was successfully updated"
    click_on "Back"
  end

  test "should destroy Device organ" do
    visit jia_bo_panel_device_organ_url(@jia_bo_panel_device_organ)
    click_on "Destroy this device organ", match: :first

    assert_text "Device organ was successfully destroyed"
  end
end
