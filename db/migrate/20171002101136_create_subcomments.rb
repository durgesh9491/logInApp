class CreateSubcomments < ActiveRecord::Migration
  def change
    create_table :subcomments do |t|
      t.text :content
      t.references :comment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
