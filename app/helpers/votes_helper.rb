module VotesHelper
  def voted(votes)
    votes.any? do |a|
      a[:user_id] == current_user.id
    end
  end

  def average_rating(v)
    arr = v.collect {|i| i[:grades].to_f }
    arr == [] ? 'No votes' : "Average vote: #{arr.inject{ |sum, el| sum + el }.to_f / arr.size} "
  end
end
  