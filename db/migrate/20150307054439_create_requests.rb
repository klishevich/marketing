class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :url
      t.string :result

      t.timestamps null: false
    end
  end
end
