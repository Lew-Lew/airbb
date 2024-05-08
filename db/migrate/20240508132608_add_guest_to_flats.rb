class AddGuestToFlats < ActiveRecord::Migration[7.1]
  def change
    add_column :flats, :guest, :integer
  end
end
