class MakeReviewsAJoinTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :name, :string
    add_column :reviews, :user_id, :integer
    Review.delete_all
  end

end
