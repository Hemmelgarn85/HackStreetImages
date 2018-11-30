#Created by Michael Hemmelgarn
json.users do
  json.array!(@users) do |user|
    json.name user.username
    json.url show_path(user.username)
  end
end
json.images do
  json.array!(@images) do |image|
    json.name image.name
    json.url image_path(image)
  end
end