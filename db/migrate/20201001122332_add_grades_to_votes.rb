class AddGradesToVotes < ActiveRecord::Migration[6.0]
  def change
    add_column :votes, :grades, :integer
  end
end
