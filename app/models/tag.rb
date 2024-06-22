class Tag < ApplicationRecord
  has_many :plant_diary_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :plant_diaries, through: :plant_diary_tags
  validates :name, uniqueness: true, presence: true

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end

  def save_plan_tags(tags)
    current_tags = self.tags.pluck(:name)
    current_tags ||= []

    tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name.strip)
      self.tags << tag unless self.tags.include?(tag)
    end

    tags_to_delete = current_tags - tags
    self.tags.where(name: tags_to_delete).destroy_all
  end
end