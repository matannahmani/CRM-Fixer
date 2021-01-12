starttime = Time.now
def trueconv(o)
  o == 'כן' ? true : false
end

def adminconv(k)
  3 if k == 'מנהל ארצי'
  2 if k == 'מנהל אזור'
end

CITIES = City.all.as_json
USER = User.new.as_json
def createUser(newuser) # pretty fast
  newuser = USER.merge(newuser)
  newuser["city_id"] = CITIES.select {|city| city["name"].include?("תל אביב")}[0]["id"]
  newuser = newuser.except!("city","מס׳ רכב","מדבקת רכב?","כרטיס מתנדב?","אופציות עזרה","סוג כלי רכב")
  newuser["adminlevel"] = adminconv(newuser["adminlevel"]) unless newuser["adminlevel"].nil?
  newuser["langauges"] = newuser["langauges"].split(',') unless newuser["langauges"].nil?
  newuser["phone"] = newuser["phone"].gsub('-','') unless newuser["phone"].nil?
  newuser["getupdates"] = true
  if !newuser["israelid"].nil?
    newuser["encrypted_password"] = User.new.send(:password_digest, newuser["israelid"])
  elsif !newuser["phone"].nil?
    newuser["encrypted_password"] = User.new.send(:password_digest, newuser["phone"])
  else
    newuser["encrypted_password"] = User.new.send(:password_digest, newuser["email"])
  end
  return newuser
end



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
puts "Loading Users this will take a while"
userfile = File.open('db/vol.json')
userjson = JSON.parse(userfile.read)
userlist = []
userjson.each do |user|
  timer = Time.now
  userlist << createUser(user)
  puts Time.now - timer
end
User.import userlist
puts "Seeding Ended | TOTAL TIME :#{Time.now - starttime}"
