class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.references :repo, index: true, foreign_key: true
      t.string :path
      t.string :name
      t.string :sha

      t.timestamps null: false
    end
  end
end
