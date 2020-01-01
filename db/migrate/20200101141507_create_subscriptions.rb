class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :amazon
      t.boolean :disney
      t.boolean :fx
      t.boolean :hbo
      t.boolean :hulu
      t.boolean :netflix
      t.boolean :showtime
      t.boolean :starz
      t.boolean :tbs
      t.boolean :tnt
      t.boolean :usa

      t.timestamps
    end
  end
end
