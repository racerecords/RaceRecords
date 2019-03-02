require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @report = reports(:one)
  end

  test "should get index" do
    get reports_url
    assert_response :success
  end

  test "should get new" do
    get new_report_url
    assert_response :success
  end

  test "should create report" do
    assert_difference('Report.count') do
      post reports_url, params: { report: { ambient_before: @report.ambient_before, barometer: @report.barometer, battery_level: @report.battery_level, classes: @report.classes, field_calibration_time: @report.field_calibration_time, humidity: @report.humidity, microphone_location: @report.microphone_location, reader: @report.reader, recorder: @report.recorder, session_id: @report.session_id, site_certification_date: @report.site_certification_date, temp: @report.temp, weather: @report.weather, wind_direction: @report.wind_direction, wind_speed: @report.wind_speed } }
    end

    assert_redirected_to report_url(Report.last)
  end

  test "should show report" do
    get report_url(@report)
    assert_response :success
  end

  test "should get edit" do
    get edit_report_url(@report)
    assert_response :success
  end

  test "should update report" do
    patch report_url(@report), params: { report: { ambient_before: @report.ambient_before, barometer: @report.barometer, battery_level: @report.battery_level, classes: @report.classes, field_calibration_time: @report.field_calibration_time, humidity: @report.humidity, microphone_location: @report.microphone_location, reader: @report.reader, recorder: @report.recorder, session_id: @report.session_id, site_certification_date: @report.site_certification_date, temp: @report.temp, weather: @report.weather, wind_direction: @report.wind_direction, wind_speed: @report.wind_speed } }
    assert_redirected_to report_url(@report)
  end

  test "should destroy report" do
    assert_difference('Report.count', -1) do
      delete report_url(@report)
    end

    assert_redirected_to reports_url
  end
end
