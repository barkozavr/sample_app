require 'rails_helper'

RSpec.describe RatingService do
  context "adheres to service template:" do
    specify "inherits from BaseService" do
      expect(RatingService.ancestors.include?(BaseService)).to be true
    end

    specify "has one public instance method" do
      n = RatingService.allocate.public_methods(false).size
      expect(n).to eq(1)
    end

    specify "does not raise errors" do
      expect { RatingService.call(nil) }.to_not raise_error
    end
  end

  describe "responds with Failure(:invalid_data)" do
    context "when not fed an Enumerable:" do
      specify "nil" do
        check_for_invalid_data(RatingService.call(nil))
      end

      specify "Integer" do
        check_for_invalid_data(RatingService.call(5))
        check_for_invalid_data(RatingService.call(0))
        check_for_invalid_data(RatingService.call(-2))
      end
    end

    context "when fed an Enumerable" do
      specify "of random classes" do
        check_for_invalid_data(
          RatingService.call([1, nil, false, RatingService])
        )
      end

      specify "of Votes and other classes" do
        check_for_invalid_data(
          RatingService.call([Vote.new(grades: 1), Vote.new(grades: 2), 3])
        )
      end

      specify "of unexpected type" do
        check_for_invalid_data(
          RatingService.call({Vote.new(grades: 1) => 1, Vote.new(grades: 2) => 3})
        )
      end
    end
  end

  describe "responds with Failure(:no_votes)" do
    specify "when fed with an empty Enumberable" do
      check_for_empty_votes(RatingService.call([]))
      check_for_empty_votes(RatingService.call({}))
    end
  end

  describe "responds with Success" do
    specify "when fed an Enumerable of Votes" do
      result = RatingService.call([Vote.new(grades: 1)])
      expect(result).to be_a(Dry::Monads::Result)
      expect(result.success?).to be true
    end

    specify "with correct value" do
      votes = [
        [1,   [Vote.new(grades: 1)]],
        [5,   [Vote.new(grades: 5), Vote.new(grades: 5)]],
        [2.5, [Vote.new(grades: 1), Vote.new(grades: 4)]],
        [3,   [1, 2, 3, 4, 5].map { Vote.new(grades: _1) }]
      ]
      votes.each do |expected_value, array|
        result = RatingService.call(array)
        check_for_success(result, expected_value)
      end
    end
  end
end

def check_for_invalid_data(result)
  expect(result).to be_a(Dry::Monads::Result)
  expect(result.failure?).to be true
  expect(result.failure).to be :invalid_data
end

def check_for_empty_votes(result)
  expect(result).to be_a(Dry::Monads::Result)
  expect(result.failure?).to be true
  expect(result.failure).to be :no_votes
end

def check_for_success(result, expected_value)
  expect(result).to be_a(Dry::Monads::Result)
  expect(result.success?).to be true
  expect(result.value!).to be_within(0.01).of(expected_value)
end
