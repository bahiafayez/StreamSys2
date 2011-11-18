class RemoveClientIdToResultingStream < ActiveRecord::Migration
  def change
    remove_column :resulting_streams, :client_id
  end
end
