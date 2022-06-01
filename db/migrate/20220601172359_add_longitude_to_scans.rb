class AddLongitudeToScans < ActiveRecord::Migration[6.1]
  def change
    add_column :scans, :longitude, :float
  end
end
