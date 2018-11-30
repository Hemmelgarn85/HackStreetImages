# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#by Ivan Lavrov
module RandomizedData
  require 'open-uri'

  def RandomizedData.rand_string repetitions
    res = ""
  
    repetitions.times do
      length = rand(4..15)
      res += rand(36**length).to_s(36) + " "
    end
    res.strip
  end
  
  def RandomizedData.email num
    "user" + num.to_s + "@test.com"
  end

  def RandomizedData.get_random_image
    random_img_host = 'https://picsum.photos/'

    #random width: 100-1500
    w = rand(5..15) * 100
    
    #random height: 100-800
    h = rand(3..15) * 100
  
    img_url = random_img_host + w.to_s + '/' + h.to_s
    downloaded_img = open(img_url)
  end

  def RandomizedData.create_image with_user_id=nil
    
    rand_img = RandomizedData.get_random_image
    imgObj = Image.new(name: RandomizedData.rand_string(1), description: "Lorem ipsum" + RandomizedData.rand_string(6))
    imgObj.image_datafile.attach(io: rand_img, filename: "someName")
    imgObj.user_id = with_user_id if !with_user_id.nil?
    imgObj.save
  end

  def RandomizedData.create_random_user num
    # Devise.include_helpers(Devise::Controllers)
    user = User.new(email: RandomizedData.email(num), username: ("user" + num.to_s), password: 'password', password_confirmation: 'password')
    user.save

    #create random user's images. upto 5 images per user
    rand_num = rand 5
    rand_num.times do
      RandomizedData.create_image user.id
    end
  end
end

5.times do RandomizedData.create_image end
5.times do |iter|
  RandomizedData.create_random_user (iter + 1)
end

# user6 = User.new(email: RandomizedData.email(6), username: ("user" + 6.to_s), password: 'password', password_confirmation: 'password')
# user7 = User.new(email: RandomizedData.email(7), username: ("user" + 7.to_s), password: 'password', password_confirmation: 'password')
