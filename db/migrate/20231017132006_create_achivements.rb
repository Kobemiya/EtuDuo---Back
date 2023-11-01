class CreateAchivements < ActiveRecord::Migration[7.0]
  def change
    create_table :achivements do |t|

      t.timestamps
    end
  end
end
