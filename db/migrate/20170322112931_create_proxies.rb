class CreateProxies < ActiveRecord::Migration[5.0]
  def change
    create_table :proxies do |t|
      t.string :site
      t.string :ip
      t.string :port

      t.timestamps
    end
  end
end
