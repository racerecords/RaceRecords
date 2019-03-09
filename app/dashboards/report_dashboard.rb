require "administrate/base_dashboard"

class ReportDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    session: Field::BelongsTo,
    readings: Field::HasMany,
    id: Field::Number,
    classes: Field::String,
    ambient_before: Field::String,
    wind_direction: Field::String,
    wind_speed: Field::String,
    weather: Field::String,
    temp: Field::String,
    humidity: Field::String,
    barometer: Field::String,
    reader: Field::String,
    recorder: Field::String,
    field_calibration_time: Field::String,
    battery_level: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :session,
    :readings,
    :id,
    :classes,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :session,
    :readings,
    :id,
    :classes,
    :ambient_before,
    :wind_direction,
    :wind_speed,
    :weather,
    :temp,
    :humidity,
    :barometer,
    :reader,
    :recorder,
    :field_calibration_time,
    :battery_level,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :session,
    :readings,
    :classes,
    :ambient_before,
    :wind_direction,
    :wind_speed,
    :weather,
    :temp,
    :humidity,
    :barometer,
    :reader,
    :recorder,
    :field_calibration_time,
    :battery_level,
  ].freeze

  # Overwrite this method to customize how reports are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(report)
  #   "Report ##{report.id}"
  # end
end
