class End < ApplicationRecord
  belongs_to :user
  belongs_to :start
  validates :user_id, presence: true
end
