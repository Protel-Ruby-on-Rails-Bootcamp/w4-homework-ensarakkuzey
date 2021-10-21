class AddVoteCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :vote_count, :integer, :default => 0
    #Ex:- :default =>''
  end
end
