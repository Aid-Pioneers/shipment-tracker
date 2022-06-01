class AddLatitudeToScans < ActiveRecord::Migration[6.1]
  def change
    add_column :scans, :latitude, :float
  end
end
