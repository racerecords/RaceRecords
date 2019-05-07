# frozen_string_literal: true

if Rails.env == 'development'
  begin
    10.times do
      event = Event.new(name: Faker::Address.city,
                        track: Faker::Address.community,
                        region: Faker::Address.state,
                        site_cert_date: Faker::Date.between(
                          1.year.ago, Date.today
                        ),
                        meter_factory_calibration_date: Faker::Date.between(
                          1.year.ago, Date.today
                        ),
                        microphone_location: Faker::Lorem.words,
                        description: Faker::Lorem.sentence)

      group = Group.new(name: Faker::Lorem.word, event_id: event.id)

      10.times do
        session = Session.new(name: Faker::Lorem.word,
                              ambient_before: Faker::Lorem.word,
                              wind_direction: Faker::Lorem.word,
                              wind_speed: Faker::Lorem.word,
                              weather: Faker::Lorem.word,
                              temp: Faker::Lorem.word,
                              humidity: Faker::Lorem.word,
                              barometer: Faker::Lorem.word,
                              reader: Faker::Lorem.word,
                              recorder: Faker::Lorem.word,
                              field_calibration_time: Date.today,
                              battery_level: Faker::Lorem.word,
                              group_id: group.id)

        10.times do
          Reading.new(session_id: session.id,
                      number: Faker::Number.number(3),
                      car_class: Faker::Lorem.word,
                      readings: Faker::Number.between(1, 5).times.map do
                                  Faker::Number.between(1, 3)
                                end.join(' '))
        end
      end
    rescue ActiveRecord::RecordNotUnique
      next
    end
  end
end
