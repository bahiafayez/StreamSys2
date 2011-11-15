class CreateLiveStreams < ActiveRecord::Migration
  def change
    create_table :live_streams do |t|
      t.string :name

      t.timestamps
    end
  end
end
