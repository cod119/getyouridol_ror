class CreateIdols < ActiveRecord::Migration
  def change
    create_table :idols do |t|
      t.string :nameko
      t.string :nameja
      t.string :nameen
      t.string :cv
      t.string :gender
      t.integer :age
      t.integer :height
      t.integer :weight
      t.integer :b
      t.integer :w
      t.integer :h
      t.string :hobby
      t.integer :month
      t.integer :day
      t.integer :birth
      t.string :bloodtype
      t.string :hairstyle
      t.string :hairstyle2
      t.string :hairstyle3
      t.string :feature
      t.string :feature2
      t.string :feature3
      t.string :areafrom
      t.string :productionorunit
      t.string :productionorunit2
      t.string :mediafromP
      t.string :mediafromP_1
      t.string :mediafromP_2
      t.string :mediafrom
      t.string :mediafrom2

      t.timestamps null: false
    end
  end
end
