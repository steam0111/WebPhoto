class Folder < ActiveRecord::Base
	belongs_to :user

	has_many :subordinates, class_name: "Folder",#имеет много подчиннёных папок
                          foreign_key: "manager_id"
    belongs_to :manager, class_name: "Folder" #имеет одну руководящую папку
end
