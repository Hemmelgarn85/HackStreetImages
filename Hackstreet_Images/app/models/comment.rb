class Comment < ApplicationRecord
    belongs_to :image
    belongs_to :user

    validates :content, presence: true, allow_blank: false
end
