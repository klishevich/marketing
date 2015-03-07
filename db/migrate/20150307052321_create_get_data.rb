class CreateGetData < ActiveRecord::Migration
  def change
    create_table :get_data do |t|
      t.string :url
      t.string :data

      t.timestamps null: false
    end
  end
end
