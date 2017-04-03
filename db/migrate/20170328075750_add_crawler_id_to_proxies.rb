class AddCrawlerIdToProxies < ActiveRecord::Migration[5.0]
  def change
    add_column :proxies, :crawler_id, :integer
  end
end
