# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env == 'development'
  10.times do 
    event = Event.create(name: 'Seed Event')
    group = Group.create(name: 'Seed Group', event_id: event.id)
    session = Session.create(name: 'Seed Session', group_id: group.id)
    10.times do
      report = Report.create(session_id: session.id)
      10.times do
        Reading.create(report_id: report.id, number: 1, car_class: 'fast', readings: 'readings')
      end
    end
  end
end
