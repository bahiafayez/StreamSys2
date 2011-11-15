class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.references :client
      t.references :category

      t.timestamps
    end
  end
end
