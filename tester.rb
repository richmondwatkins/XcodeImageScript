require 'plist'
require 'fileutils'
require 'json'
#system('git clone https://github.com/richmondwatkins/InstagramClone 2')

#result = Plist::parse_xml('scriptTest/fa-firefly-15-Info.plist')
result = Plist::parse_xml('scriptTest/ProjectSpecific/Data/project_settings.plist')

#def festival_short_name(result)
#    entry = gets.chomp
#
#    if entry.length <= 0
#        entry = result['General']['FestivalName']
#    end
#
#    entry
#end
#
#puts 'Enter festival name'
#result['General']['FestivalName'] = gets.chomp
#
#puts 'Enter short name (hit enter to use full name)'
#result['General']['FestivalShortName'] = festival_short_name(result)
#
#puts 'Enter festival location (city, state)'
#result['General']['FestivalLocation'] = gets.chomp
#
#puts 'Enter timezone'
#result['General']['FestivalTimeZone'] = gets.chomp
#
#puts 'Enter AppID'
#result['General']['MasterAppID'] = gets.chomp
#
#
#puts result['General']

#puts 'Enter # of Nav Items'
#nav_item_number = gets.to_i
#
#
#def set_up_nav_items
#    nav_item = Hash.new
#
#    puts 'Enter menu item name'
#    nav_item["Title"] = gets.chomp
#    puts 'Enter class of menu item'
#    nav_item["Class"] = gets.chomp
#    puts 'Enter icon name'
#    nav_item["IconName"] = gets.chomp
#
#    nav_item
#end
#
#iPhoneNavItems = []
#nav_item_number.times do
#    iPhoneNavItems <<set_up_nav_items
#    puts iPhoneNavItems
#    puts iPhoneNavItems.class
#end
#
#
#result['iPhoneNavItems'] = iPhoneNavItems
#
##result['CFBundleName'] = 'jerry'
##result['CFBundleIdentifier'] = 'com.richmond.$(PRODUCT_NAME)'
#result.to_plist
#result.save_plist('project_settings.plist')
##
#FileUtils.rm('scriptTest/ProjectSpecific/Data/project_settings.plist')
##
#FileUtils.mv('project_settings.plist', 'scriptTest/ProjectSpecific/Data/project_settings.plist')



#CFBundleDevelopmentRegion - language
#CFBundleExecutable - Executable File
#CFBundleIdentifier - Bundle ID
#CFBundleName - Bundle name

#Path to project_assets 'scriptTest/ProjectSpecific/Assets/project_specific.xcassets'
assets_path = 'scriptTest/ProjectSpecific/Assets/project_specific.xcassets/'

FileUtils.rm_rf(Dir.glob(assets_path))

puts 'Drag icon folder into terminal'
path_to_photos = gets
directory = "photos/**/*.png"

directory = Dir[directory]


def createJsonfile(jsonImagesArray)
    puts jsonImagesArray
    x = ""
    xx = ""
    xxx = ""

    jsonImagesArray.each do |image|
        if image.include? "@3x"
            xxx = File.basename(image)
        elsif image.include? "@2x"
            xx = File.basename(image)
        else
            x = File.basename(image)
        end
    end

    content = '{
    "images" : [
    {
        "idiom" : "universal",
        "scale" : "1x",
        "filename" : "'"#{ x }"'"
				},
    {
        "idiom" : "universal",
        "scale" : "2x",
        "filename" : "'"#{ xx }"'"
    },

    {
        "idiom" : "universal",
        "scale" : "3x",
        "filename" : "'"#{ xxx }"'"
    }
  		],
        "info" : {
            "version" : 1,
            "author" : "xcode"
        }
        }'

        target  = "Contents.json"

        File.open(target, "w+") do |f|
            f.write(content)
        end

        target
end


createdDirectories = [];

directory.each do |file|
    assetName = File.basename(file,'.*')

    assetNameWithout2xOr3X = ""
    imageSetName = ""

    if assetName.include? "@2x"
        assetNameWithout2xOr3X = assetName.gsub("@2x", "")
        imageSetName = "#{ assetNameWithout2xOr3X }.imageset"

    elsif assetName.include? "@3x"
        assetNameWithout2xOr3X = assetName.gsub("@3x", "")
        imageSetName = "#{ assetNameWithout2xOr3X }.imageset"
    else

        imageSetName = "#{ assetName }.imageset"
        assetNameWithout2xOr3X = imageSetName
    end


    if File.directory?("#{imageSetName}") == false
         Dir.mkdir(imageSetName)
        createdDirectories << imageSetName
    end

    FileUtils.cp("#{file}", "#{imageSetName}")
end


createdDirectories.each do |dir|

    jsonImagesArray = []
    Dir["#{dir}/*"].each do |file|
        jsonImagesArray << file
    end
#    jsonImagesArray = jsonImagesArray.map { |o| o.to_json }

    jsonFile = createJsonfile(jsonImagesArray)

    FileUtils.mv("#{jsonFile}", "#{dir}")
    FileUtils.mv("#{dir}", "#{assets_path}")

end



#PhoneNavItems"=>[{"Class"=>"FAMapTabViewController", "IconName"=>"map_menu_ic", "Title"=>"Map"}, {"Class"=>"FALineupTabVC", "IconName"=>"menu_lineup_ic", "Title"=>"My Scheudle & Lineup"}, {"Class"=>"FAWhatsHotVC", "IconName"=>"menu_heart_btn", "Title"=>"Firefly Favorites"}, {"Class"=>"FAPoiTabViewController", "IconName"=>"menu_eatdrink_ic", "Title"=>"Festival Experience"}, {"IconName"=>"menu_social_ic", "Title"=>"News & Social", "Class"=>"FANewsTabVC"}, {"Class"=>"FaqVC", "IconName"=>"menu_question_btn", "Title"=>"Pre-Festival Guide"}, {"URL"=>"http://aloo.mp/fireflywristbands", "IconName"=>"menu_wristband_ic", "Title"=>"Wristband Activation"}, {"Class"=>"FARadioPlayerViewController", "IconName"=>"menu_radio_btn", "Title"=>"Firefly Radio"}]}