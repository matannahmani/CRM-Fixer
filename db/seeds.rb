
def trueconv(o)
  o == 'כן' ? true : false
end

def adminconv(k)
  3 if k == 'מנהל ארצי'
  2 if k == 'מנהל אזור'
end
CITIES = City.all.as_json
def createUser(newuser)
  start = Time.now
  user = User.new
  # binding.pry
  # newuser["city"] = CITIES.where("name like ?", "%#{newuser[:city]}%")[0].id
  newuser["city_id"] = CITIES.select {|city| city["name"].include?("תל אביב")}[0]["id"]
  newuser["adminlevel"] = adminconv(newuser["adminlevel"]) unless newuser["adminlevel"].nil?
  newuser["langauges"] = newuser["langauges"].split(',') unless newuser["langauges"].nil?
  newuser["phone"] = newuser["phone"].gsub('-','') unless newuser["phone"].nil?
  # newuser["gender"] = newuser["gender"] == 'גבר' unless newuser["gender"].nil?
  newuser["getupdates"] = true
  if !newuser["israelid"].nil?
    newuser["password"] = newuser["israelid"]
  elsif !newuser["phone"].nil?
    newuser["password"] = newuser["phone"]
  else
    newuser["password"] = newuser["email"]
  end
  # newuser.each do |o,k|
  #   if o == "city"
  #     user.city = City.where("name like ?", "%#{newuser[:city]}%")[0]
  # #   elsif o == "adminlevel"
  # #       user[o] = adminconv(k)
  # #   elsif o == "langauges"
  # #       user[o] = k.split(',')
  # #   elsif o == "phone"
  # #       user[o] = k.gsub('-','')
  # #   elsif o == "gender"
  # #       user[o] = k == "גבר"
  # #   else
  # #       if user.has_attribute?(o)
  # #         k == 'כן' || k == 'לא' ? user[o] = trueconv(k) : user[o] = k
  # #       end
  # #       if o === newuser.keys.last
  # #         if !newuser["israelid"].nil?
  # #           user.password = newuser["israelid"]
  # #         elsif !newuser["phone"].nil?
  # #           user.password = newuser["phone"]
  # #         else
  # #           user.password = newuser["email"]
  # #         end
  # #         user[:adminlevel] = 0 if user[:adminlevle].nil?
  # #         user[:getupdates] = true
  # #     end
  #   end
  # end
  puts Time.now - start
  user
end



# puts "Starting Seed"
# puts "Destroying current regions and cities"
# puts Region.destroy_all
# puts "Finished Destroying current regions and cities"
# puts "Destroying current help options"
# puts HelpOption.destroy_all
# puts "Creating Help Options"
# HelpOption.create(descriptionvol: "קניות לקשישים ומבודדים", descriptioncall: "איסוף קניות מהסופר(לא תרומה)")
# HelpOption.create(descriptionvol: "קקניית תרופות לקשישים ובעלי מוגבלות", descriptioncall: "איסוף תרופות(לא תרומה)")
# HelpOption.create(descriptionvol: "תרומת מצרכי מזון", descriptioncall: "תרומת מזון")
# HelpOption.create(descriptionvol: "הסעת קשישים ובעלי מוגבלות", descriptioncall: "הסעה לטיפול רפואי לקשישים ומוגבלי ניידות")
# HelpOption.create(descriptionvol: "סיוע בתיקון בבית", descriptioncall: "סיוע בתיקון בבית")
# HelpOption.create(descriptionvol: "עזרה במטה הטלפוני", descriptioncall: "תמיכה טלפונית - ללא ייעוץ מקצועי")
# HelpOption.create(descriptionvol: "סיוע בשימוש אינטרנטי", descriptioncall: "סיוע בחיבור לזום ושימוש באינטרנט")
# HelpOption.create(descriptionvol: "לקחת חלק בפעילות של סולידריות ישראלית בקמפוס שלי", descriptioncall: "")
# HelpOption.create(descriptionvol: "תרומה כספית להמשך פעילות", descriptioncall: "")
# HelpOption.create(descriptionvol: "לא פנוי/ה להתנדב אבל רוצה להישאר מעודכן/ת", descriptioncall: "")
# HelpOption.create(descriptionvol: "בישול מזון חם לנזקקים", descriptioncall: "")
# HelpOption.create(descriptionvol: "סיוע לאוכלוסיות שאינן דוברות עברית", descriptioncall: "")
# puts "finished Creating Help Options"
# puts "Loading Region list"
# regionfile = File.open('db/region.json')
# regionjson = JSON.parse(regionfile.read)
# zoneobject = regionjson.map { |i| [ i["region"], i["name"] ] }
# zoneobject.reject! { |i| i[1] =~ /\A\d+\z/ || i[1] =~ /^\s+\d+/ || i[1] =~ /^\s+$/ }
# regionls = zoneobject.map { |i| i[0] }.uniq
# puts "Creating Regions"
# puts regionls.each { |i| Region.create(name: i) }
# puts "Finished Creating Regions"
# puts "Creating Cities"
# puts zoneobject.each { |i| City.create(region: Region.find_by(name: i[0]), name: i[1])}
# puts "Finished Creating Cities"
starttime = Time.now
puts "Loading Users"
userfile = File.open('db/vol.json')
userjson = JSON.parse(userfile.read)
User.transaction do
  userlist = []
  userjson.each {|user| userlist << createUser(user)}
  # User.import userlist
end
puts "Seeding Ended #{Time.now - starttime}"
