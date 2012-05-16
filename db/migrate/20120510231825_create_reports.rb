class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name, :null => false
      t.string :description
      t.column :queries, :mediumtext
      t.references :server

      t.timestamps
    end

    add_index :reports, :server_id
  end
end
