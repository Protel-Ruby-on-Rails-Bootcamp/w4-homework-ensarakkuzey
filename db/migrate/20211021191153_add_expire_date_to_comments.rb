class AddExpireDateToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :expire_date, :date, :default => DateTime.now + 2.days
    #Ex:- :default =>''
  end
end
