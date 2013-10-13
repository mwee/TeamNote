class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :sharer_id
      t.integer :shared_id

      t.timestamps
    end
  end
end
