class AddTypeToProxies < ActiveRecord::Migration[5.0]
  def change
    add_column :proxies, :type, :string
  end
end
