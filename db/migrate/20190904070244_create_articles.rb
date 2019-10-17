class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :place
      t.string :learn
      t.text :content
      t.timestamps
    end
  end
end
