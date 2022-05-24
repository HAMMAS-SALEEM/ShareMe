class ChangePostCounterDefaultValue < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :Posts_Counter, 0
  end
end
