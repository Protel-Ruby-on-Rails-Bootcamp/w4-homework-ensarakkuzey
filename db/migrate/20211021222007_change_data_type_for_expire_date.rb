class ChangeDataTypeForExpireDate < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :expire_date, :datetime, :default => nil
  end
end
