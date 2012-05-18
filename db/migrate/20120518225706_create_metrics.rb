class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.integer :report_id, :null => false
      t.integer :server_id
      t.string :query, :null => false
      t.integer :scale, :default => 0, :null => false
      t.timestamps
    end

    add_index :metrics, :report_id
    add_index :metrics, :server_id
    add_index :metrics, [:server_id, :report_id]
  end
end
