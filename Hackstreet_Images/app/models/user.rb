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

  has_many :active_relationships,  class_name:  "Relationship",
                                      foreign_key: "follower_id",
                                      dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                      foreign_key: "followed_id",
                                      dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # added by Ivan Lavrov
  # follows a user.
  def follow(a_user)
    following << a_user
  end

  # nnfollows a user.
  def unfollow(a_user)
    following.delete(a_user)
  end

  # check if the user follows a given user
  def following?(a_user)
    following.include?(a_user)
  end

end
