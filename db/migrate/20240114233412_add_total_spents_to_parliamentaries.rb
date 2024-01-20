# frozen_string_literal: true

# AddTotalSpentsToParliamentaries
class AddTotalSpentsToParliamentaries < ActiveRecord::Migration[6.1]
  def change
    add_column :parliamentaries, :total_spents, :float
  end
end
