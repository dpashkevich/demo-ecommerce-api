class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.string :email, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
