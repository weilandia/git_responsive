class AddShaToRepo < ActiveRecord::Migration
  def change
    add_column :repos, :sha, :string
  end
end
