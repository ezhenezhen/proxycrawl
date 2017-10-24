class CreateSocks < ActiveRecord::Migration[5.0]
  def change
    create_table :socks do |t|
      t.string :ip
      t.string :port
      t.string :socks_type

      t.timestamps
    end
  end
end
