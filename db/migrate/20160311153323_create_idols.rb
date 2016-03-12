class CreateIdols < ActiveRecord::Migration
  def change
    create_table :idols do |t|
      t.string :nameko
      t.string :nameja
      t.string :nameen
      t.integer :age
      t.string :productionorunit

      t.timestamps null: false
    end
  end
end
