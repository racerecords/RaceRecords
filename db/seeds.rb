# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env == 'development'
  10.times do
    event = Event.create(name: Faker::Address.city,
                         track: Faker::Address.community,
                         region: Faker::Address.state,
                         site_cert_date: Faker::Date.between(
                           1.year.ago, Date.today
                         ),
                         meter_factory_clibration_date: Faker::Date.between(
                           1.year.ago, Date.today
                         ),
                         microphone_location: Faker::Lorem.words,
                         description: Faker::Lorem.sentence)
    group = Group.create(name: Faker::Lorem.word, event_id: event.id)
    10.times do
      session = Session.create(name: Faker::Lorem.word,
                               classes: Faker::Lorem.words.split,
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
        Reading.create(session_id: session.id,
                       number: Faker::Number.number(3),
                       car_class: Faker::Lorem.word,
                       readings: Faker::Number.between(1, 5).times.map do
                         Faker::Number.between(1, 3)
                       end.join(' '))
      end
    end
  end
end
