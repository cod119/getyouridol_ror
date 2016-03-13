class CreateIdols < ActiveRecord::Migration
  def change
    create_table :idols do |t|
      t.string :nameko
      t.string :nameja
      t.string :nameen
      t.integer :age
      t.string :productionorunit
      t.string :productionorunit2

      t.timestamps null: false
    end
  end
end
