class ChangeTableItemType < ActiveRecord::Migration[7.1]
  def change
    rename_column :items, :type, :tag
  end
end
