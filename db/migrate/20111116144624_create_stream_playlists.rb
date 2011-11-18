class CreateStreamPlaylists < ActiveRecord::Migration
  def change
    create_table :stream_playlists do |t|
      t.integer :order
      t.references :resulting_stream
      t.references :playlist

      t.timestamps
    end
  end
end
