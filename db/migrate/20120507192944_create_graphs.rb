class CreateGraphs < ActiveRecord::Migration
  def change
    create_table :graphs do |t|
      t.string :name
      t.text :description
      t.string :query
      t.references :server

      t.timestamps
    end

    add_index :graphs, :server_id
  end
end
