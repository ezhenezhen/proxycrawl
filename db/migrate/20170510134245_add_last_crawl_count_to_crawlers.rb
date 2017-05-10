class AddLastCrawlCountToCrawlers < ActiveRecord::Migration[5.0]
  def change
    add_column :crawlers, :last_crawl_count, :integer, default: 0
  end
end
