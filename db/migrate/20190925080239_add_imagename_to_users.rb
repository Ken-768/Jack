class AddImagenameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :imagename, :string
  end
end
