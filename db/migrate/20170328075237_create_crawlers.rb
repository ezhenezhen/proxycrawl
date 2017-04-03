class CreateCrawlers < ActiveRecord::Migration[5.0]
  def change
    create_table :crawlers do |t|
      t.string :name
      t.boolean :is_active, default: true
      t.string :status
      t.string :link
      t.datetime :last_ran_at

      t.timestamps
    end
  end
end
