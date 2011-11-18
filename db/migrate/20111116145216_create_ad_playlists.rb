class CreateAdPlaylists < ActiveRecord::Migration
  def change
    create_table :ad_playlists do |t|
      t.integer :time
      t.references :playlist
      t.references :ad
      t.timestamps
    end
  end
end
