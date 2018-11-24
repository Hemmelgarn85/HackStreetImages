# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

module ImageSeeding
  require 'open-uri'

  def ImageSeeding.rand_string repetitions
    res = ""
  
    repetitions.times do
      length = rand(10) + 1
      res += rand(36**length).to_s(36) + " "
    end
    res.strip
  
    return res
  end
  
  def ImageSeeding.create_images
    random_img_host = 'https://picsum.photos/'
  
    20.times do |x|
      #random width: 100-1500
      w = rand(1..15) * 100
    
      #random height: 100-800
      h = rand(1..8) * 100
    
      img_url = random_img_host + w.to_s + '/' + h.to_s
      downloaded_img = open(img_url)
      Image.create!(name: ImageSeeding.rand_string(3), description: "Lorem ipsum" + ImageSeeding.rand_string(6))
      Image.last.image_datafile.attach(io: downloaded_img, filename: "randomName")
    end
  end
end

ImageSeeding.create_images