require 'rails_helper'

RSpec.describe Vote, type: :model do
  user = User.create(name: 'Example User', email: 'user@example.com',
                     password: 'foobar', password_confirmation: 'foobar')
  post = user.microposts.build(content: "Test message")
  post.save
  vote = post.votes.create(grades: 5, user_id: user.id)

  describe 'creation' do
    it 'must be valid' do
      
      not_valid_vote = post.votes.create(grades: 6, user_id: user.id)
      expect(vote).to be_valid
      expect(not_valid_vote).not_to be_valid
    end
  end
end
