class Start < ApplicationRecord
  belongs_to :user
  has_one :end, dependent: :destroy
  validates :user_id, presence: true
end
