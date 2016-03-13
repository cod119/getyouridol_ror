# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
json = ActiveSupport::JSON.decode(File.read('db/seeds/Namuami_withoutno_prod2.json'))
json.each do |a|
  list = a.symbolize_keys
  Idol.create(list.slice(:nameko,:nameja,:nameen,:age,:productionorunit,:productionorunit2))
end
