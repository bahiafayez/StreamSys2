class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :state
      t.integer :resulting_stream_id
      t.integer :proxy_id
      t.timestamps
    end
  end
end
