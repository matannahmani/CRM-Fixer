# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Starting Seed"
puts "Destroying current regions and cities"
puts Region.destroy_all
puts "Finished Destroying current regions and cities"
puts "Destroying current help options"
puts HelpOption.destroy_all
puts "Creating Help Options"
HelpOption.create(descriptionvol: "קניות לקשישים ומבודדים", descriptioncall: "איסוף קניות מהסופר(לא תרומה)")
HelpOption.create(descriptionvol: "קקניית תרופות לקשישים ובעלי מוגבלות", descriptioncall: "איסוף תרופות(לא תרומה)")
HelpOption.create(descriptionvol: "תרומת מצרכי מזון", descriptioncall: "תרומת מזון")
HelpOption.create(descriptionvol: "הסעת קשישים ובעלי מוגבלות", descriptioncall: "הסעה לטיפול רפואי לקשישים ומוגבלי ניידות")
HelpOption.create(descriptionvol: "סיוע בתיקון בבית", descriptioncall: "סיוע בתיקון בבית")
HelpOption.create(descriptionvol: "עזרה במטה הטלפוני", descriptioncall: "תמיכה טלפונית - ללא ייעוץ מקצועי")
HelpOption.create(descriptionvol: "סיוע בשימוש אינטרנטי", descriptioncall: "סיוע בחיבור לזום ושימוש באינטרנט")
HelpOption.create(descriptionvol: "לקחת חלק בפעילות של סולידריות ישראלית בקמפוס שלי", descriptioncall: "")
HelpOption.create(descriptionvol: "תרומה כספית להמשך פעילות", descriptioncall: "")
HelpOption.create(descriptionvol: "לא פנוי/ה להתנדב אבל רוצה להישאר מעודכן/ת", descriptioncall: "")
HelpOption.create(descriptionvol: "בישול מזון חם לנזקקים", descriptioncall: "")
HelpOption.create(descriptionvol: "סיוע לאוכלוסיות שאינן דוברות עברית", descriptioncall: "")
puts "finished Creating Help Options"
puts "Loading Region list"
regionfile = File.open('db/region.json')
regionjson = JSON.parse(regionfile.read)
zoneobject = regionjson.map { |i| [ i["region"], i["name"] ] }
zoneobject.reject! { |i| i[1] =~ /\A\d+\z/ || i[1] =~ /^\s+\d+/ || i[1] =~ /^\s+$/ }
regionls = zoneobject.map { |i| i[0] }.uniq
puts "Creating Regions"
puts regionls.each { |i| Region.create(name: i) }
puts "Finished Creating Regions"
puts "Creating Cities"
puts zoneobject.each { |i| City.create(region: Region.find_by(name: i[0]), name: i[1])}
puts "Finished Creating Cities"
puts "Creating Admin Account"
user = User.new(name: "מתן", lastname: "נחמני", email: "matanleague@gmail.com", password: "123456", phone: "0542124011", address: "כליל החורש 26", israelid: 211890652, adminlevel: 4, city_id: City.first.id, student: true, gender: true, healthcheck: true)
UserOption.create(user: user, helpoption: HelpOption.last)
user.save!
puts "Seeding Ended"
