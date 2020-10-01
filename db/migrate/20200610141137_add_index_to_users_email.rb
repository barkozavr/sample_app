class AddIndexToUsersEmail < ActiveRecord::Migration[6.0]
  def change
    # метот рельс add_index добавляет индекс в столбец электронной почты.
    # опция true создаёт уникальность
    add_index :users, :email, unique: true
  end
end
