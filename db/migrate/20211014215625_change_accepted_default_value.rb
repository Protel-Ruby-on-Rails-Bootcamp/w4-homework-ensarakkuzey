class ChangeAcceptedDefaultValue < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :accepted, :boolean, :default => false
  end
end
