module VotesHelper
  # check it for 'vote', made by current_user
  def voted(votes)
    votes.any? do |a|
      a[:user_id] == current_user.id
    end
  end
end
