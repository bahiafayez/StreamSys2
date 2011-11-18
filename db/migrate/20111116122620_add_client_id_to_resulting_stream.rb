class AddClientIdToResultingStream < ActiveRecord::Migration
  def change
    add_column :resulting_streams, :client_id, :Integer 
  end
end
