class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.integer :time
      t.references :ad
      t.references :resulting_stream
      
      t.timestamps
    end
  end
end
