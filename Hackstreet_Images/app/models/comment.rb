class Comment < ApplicationRecord
    attr_accessor :content
    belongs_to :image
end
