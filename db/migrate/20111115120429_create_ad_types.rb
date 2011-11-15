class CreateAdTypes < ActiveRecord::Migration
  def change
    create_table :ad_types do |t|
      t.references :ad
      t.references :category

      t.timestamps
    end
  end
end
