class AddFieldsToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :bank, :string
    add_column :requests, :p_name, :string
    add_column :requests, :p_code, :string
    add_column :requests, :p_sum_rub, :integer, :limit => 8
    add_column :requests, :p_sum_foreign, :integer, :limit => 8
    add_column :requests, :p_sum_total, :integer, :limit => 8
  end
end
