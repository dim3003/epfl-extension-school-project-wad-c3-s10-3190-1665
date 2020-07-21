class CreatePinModels < ActiveRecord::Migration[5.1]
  def change
    create_table :pin_models do |t|
      t.string :title
      t.string :image_url
      t.string :tag

      t.timestamps
    end
  end
end
