class AddHeadToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :head, :integer
  end
end
