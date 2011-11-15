class CreateResultingStreams < ActiveRecord::Migration
  def change
    create_table :resulting_streams do |t|
      t.string :type
      t.integer :proxy_id
      t.integer :live_stream_id
      t.timestamps
    end
  end
end
