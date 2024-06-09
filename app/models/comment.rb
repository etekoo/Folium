class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :plant_diary
    
    validates :content, presence: true
end
