class Delete < ActiveRecord::Migration[7.0]
  def change
    drop_table :achivements
  end
end
