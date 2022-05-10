class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :Name
      t.text :Photo
      t.text :Bio
      t.timestamps
      t.bigint :Posts_Counter
    end
  end
end