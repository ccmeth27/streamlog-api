class CreateUserPrograms < ActiveRecord::Migration[6.0]
  def change
    create_table :user_programs do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :guidebox_id
      t.string :imdb_id
      t.boolean :is_seen
      t.boolean :is_rejected
      t.boolean :is_watchlist
      t.boolean :is_movie
      t.string :title
      t.string :poster
      t.string :release_year

      t.timestamps
    end
  end
end
