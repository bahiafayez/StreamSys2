class AddNameToResultingStreams < ActiveRecord::Migration
  def change
    add_column :resulting_streams, :name, :string
  end
end
