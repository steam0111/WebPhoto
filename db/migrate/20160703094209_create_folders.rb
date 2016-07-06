class CreateFolders < ActiveRecord::Migration
 def change
    create_table :folders do |t|
      t.string :foldername
      t.timestamps null: false

      t.references :manager, index: true
    end
  end
end
