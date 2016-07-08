class AddReference < ActiveRecord::Migration
  def change
  	add_reference :photos, :folder, index: true
  	add_reference :photos, :user, index: true
  end
end
