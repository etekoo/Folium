class Contact < ApplicationRecord
  belongs_to :user

  enum status: { pending: 0, in_progress: 1, resolved: 2, closed: 3 }

  validates :title, presence: true
  validates :message, presence: true
end