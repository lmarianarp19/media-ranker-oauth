class AddOwnerToWorks < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :owner, :string
  end
end
