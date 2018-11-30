class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true
  validates_length_of :username, :minimum => 3       
  has_one_attached :profile_image_datafile
  has_many :images, dependent: :destroy # if the use is deleted, then delete all associated images and comments
  has_many :comments, dependent: :destroy
end
