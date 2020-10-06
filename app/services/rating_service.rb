class RatingService < BaseService
  include Dry::Monads[:result]

  def initialize(data)
    @data = data
  end

  def call()
    return Failure(:invalid_data) unless valid?(@data)
    return Failure(:no_votes) if @data.empty?
    Success(@data.reduce(0) { |sum, vote| sum + vote.grades } / @data.size.to_f)
  end

  private

  def valid?(collection)
    return false unless collection.is_a?(Enumerable)
    return false unless collection.all?(Vote)
    true
  end
end
