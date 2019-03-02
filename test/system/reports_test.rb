require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:one)
  end

  test "visiting the index" do
    visit reports_url
    assert_selector "h1", text: "Reports"
  end

  test "creating a Report" do
    visit reports_url
    click_on "New Report"

    fill_in "Ambient before", with: @report.ambient_before
    fill_in "Barometer", with: @report.barometer
    fill_in "Battery level", with: @report.battery_level
    fill_in "Classes", with: @report.classes
    fill_in "Field calibration time", with: @report.field_calibration_time
    fill_in "Humidity", with: @report.humidity
    fill_in "Microphone location", with: @report.microphone_location
    fill_in "Reader", with: @report.reader
    fill_in "Recorder", with: @report.recorder
    fill_in "Session", with: @report.session_id
    fill_in "Site certification date", with: @report.site_certification_date
    fill_in "Temp", with: @report.temp
    fill_in "Weather", with: @report.weather
    fill_in "Wind direction", with: @report.wind_direction
    fill_in "Wind speed", with: @report.wind_speed
    click_on "Create Report"

    assert_text "Report was successfully created"
    click_on "Back"
  end

  test "updating a Report" do
    visit reports_url
    click_on "Edit", match: :first

    fill_in "Ambient before", with: @report.ambient_before
    fill_in "Barometer", with: @report.barometer
    fill_in "Battery level", with: @report.battery_level
    fill_in "Classes", with: @report.classes
    fill_in "Field calibration time", with: @report.field_calibration_time
    fill_in "Humidity", with: @report.humidity
    fill_in "Microphone location", with: @report.microphone_location
    fill_in "Reader", with: @report.reader
    fill_in "Recorder", with: @report.recorder
    fill_in "Session", with: @report.session_id
    fill_in "Site certification date", with: @report.site_certification_date
    fill_in "Temp", with: @report.temp
    fill_in "Weather", with: @report.weather
    fill_in "Wind direction", with: @report.wind_direction
    fill_in "Wind speed", with: @report.wind_speed
    click_on "Update Report"

    assert_text "Report was successfully updated"
    click_on "Back"
  end

  test "destroying a Report" do
    visit reports_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Report was successfully destroyed"
  end
end
