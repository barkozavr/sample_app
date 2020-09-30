class Vote < ApplicationRecord
  # is it correct assotiations for my task? (has_many in user- and micropost models also)
  belongs_to :user
  belongs_to :micropost
end
