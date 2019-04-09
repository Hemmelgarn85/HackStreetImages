# Project 6
### Ruby on Rails Project

Comment for Those viewing commits.
I (Michael Hemmelgarn) used to have two github accounts. I did quite a few commits on this repo with that account
but i have since deleted it to merge the two accounts. That is why it would appear I am missing commits.

### Roles
* Overall Project Manager: Michael Hemmelgarn
* Coding Manager: Jalen Soat
* Testing Manager: Graham Tschieder
* Documentation: Ivan Lavrov

### Contributions

- Jalen Soat: Comments, overall styling
- Graham Tschieder: Feed filtering, privacy, user information / page
- Michael: User/Image Searching, overall styling
- Ivan Lavrov: User/Image generation, image storing, image display, followers
- Nick Nitta: Followers, overall styling, likes count and author links

### Code Organization/Structure
- This code is structured in the style of the standard rails paradigm. This is a standard model-view-controller format, which each part communicating throughout the code. All models are found in the "models" folder, all view are found in the "views" folder, and all controllers are found in the "controllers" folder. Bootstrap was used in styling to make the project look cleaner, and devise was used to assist with user log in / account creation.  

### How to Run Code
- Ensure you are in the "Hackstreet_Images" directory. Then, install all gems using the "bundle install" command. To run the server, use the "rails s" command. Once the server is running, on your browser of choice, go to "localhost:3000", and the website will run.

### Gems Required
- gem 'rails', '~> 5.2.1'
- gem 'sqlite3'
- gem 'puma', '~> 3.11'
- gem 'sass-rails', '~> 5.0'
- gem 'uglifier', '>= 1.3.0'
- gem 'coffee-rails', '~> 4.2'
- gem 'turbolinks', '~> 5'
- gem 'jbuilder', '~> 2.5'
- gem 'mini_magick', '~> 4.8'
- gem 'bootsnap', '>= 1.1.0', require: false
- gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
- gem 'web-console', '>= 3.3.0'
- gem 'listen', '>= 3.0.5', '< 3.2'
- gem 'spring'
- gem 'spring-watcher-listen', '~> 2.0.0'
- gem 'capybara', '>= 2.15'
- gem 'selenium-webdriver'
- gem 'chromedriver-helper'
- gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
- gem 'bootstrap-sass', '3.3.7'
- gem 'sprockets-rails', '~> 3.2.1'
- gem 'ransack', '~> 2.1'

### Testing
**Unit**
  -Some unit tests were created to ensure specific moduals worked as intenteded. To run these tests type rails tests.
  
**Integration**
  -For integration testing, when moduals were completed that were related, they were grouped together and ran while being
  monitered to ensure they were working as intended.
  
**System**
  -To ensure the entire website worked, the website was extesively browsed and used in a destructive manner. This helped us
  ensure that the entire website cooperated and worked nicely from a users perspective.
