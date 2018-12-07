class CreateRatingScales < ActiveRecord::Migration
  def change
    create_table :rating_scales do |t|
      t.integer :stars
      t.string :description

      t.timestamps null: false
    end
  end
end
