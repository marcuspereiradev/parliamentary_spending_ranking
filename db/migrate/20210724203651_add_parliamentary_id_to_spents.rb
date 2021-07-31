class AddParliamentaryIdToSpents < ActiveRecord::Migration[6.1]
  def change
    add_column :spents, :parliamentary_id, :string
    add_index :spents, :parliamentary_id
  end
end
