class CreateIdols < ActiveRecord::Migration
  def change
    create_table :idols do |t|
      t.string :nameko
      t.string :nameja
      t.string :nameen
      t.string :cv
      t.string :gender
      t.integer :age
      t.string :productionorunit
      t.string :productionorunit2
      t.integer :height
      t.integer :weight
      t.integer :b
      t.integer :w
      t.integer :h
      t.string :hobby
      t.integer :birth
      t.string :bloodtype
      t.string :hairstyle
      t.string :areafrom
      t.string :mediafrom
      t.string :mediafrom2

      t.timestamps null: false
    end
  end
end
