class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :resulting_streams, :type, :streamType
  end

  def down
  end
end
