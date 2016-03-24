# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
json = ActiveSupport::JSON.decode(File.read('db/seeds/Namuami2.json'))
json.each do |a|
  list = a.symbolize_keys
  Idol.create(list.slice(:nameko,:nameja,:nameen,:cv,:gender,:age,:height,:weight,:b,:w,:h,:hobby,:birth,:month,:day,:bloodtype,:hairstyle,:hairstyle2,:hairstyle3,:feature,:feature2,:feature3,:areafrom,:productionorunit,:productionorunit2,:mediafromp,:mediafromp_1,:mediafromp_2,:mediafrom,:mediafrom2))
end
