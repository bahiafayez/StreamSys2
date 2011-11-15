class CreateStreamTypes < ActiveRecord::Migration
  def change
    create_table :stream_types do |t|
      t.references :live_stream
      t.references :category

      t.timestamps
    end
  end
end
