class CreateProxies < ActiveRecord::Migration
  def change
    create_table :proxies do |t|
      t.string :IP
      t.integer :Port

      t.timestamps
    end
  end
end
