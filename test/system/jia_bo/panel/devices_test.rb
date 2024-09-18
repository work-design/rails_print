require "application_system_test_case"

class DevicesTest < ApplicationSystemTestCase
  setup do
    @jia_bo_panel_device = jia_bo_panel_devices(:one)
  end

  test "visiting the index" do
    visit jia_bo_panel_devices_url
    assert_selector "h1", text: "Devices"
  end

  test "should create Device" do
    visit jia_bo_panel_devices_url
    click_on "New Device"

    fill_in "Dev name", with: @jia_bo_panel_device.dev_name
    fill_in "Device", with: @jia_bo_panel_device.device_id
    fill_in "Grp", with: @jia_bo_panel_device.grp_id
    click_on "Create Device"

    assert_text "Device was successfully created"
    click_on "Back"
  end

  test "should update Device" do
    visit jia_bo_panel_devices_url
    click_on "Edit", match: :first

    fill_in "Dev name", with: @jia_bo_panel_device.dev_name
    fill_in "Device", with: @jia_bo_panel_device.device_id
    fill_in "Grp", with: @jia_bo_panel_device.grp_id
    click_on "Update Device"

    assert_text "Device was successfully updated"
    click_on "Back"
  end

  test "should destroy Device" do
    visit jia_bo_panel_devices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Device was successfully destroyed"
  end
end
