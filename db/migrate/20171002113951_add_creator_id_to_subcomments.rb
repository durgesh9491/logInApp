class AddCreatorIdToSubcomments < ActiveRecord::Migration
  def change
    add_column :subcomments, :creator_id, :integer
  end
end
