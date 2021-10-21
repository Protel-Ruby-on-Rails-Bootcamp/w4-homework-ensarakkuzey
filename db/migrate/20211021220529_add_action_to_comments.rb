class AddActionToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :action, :boolean, :default => false
    #Ex:- :default =>''
  end
end
