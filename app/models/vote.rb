class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :grades, :inclusion => 1..5
end
