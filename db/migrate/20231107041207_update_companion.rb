class UpdateCompanion < ActiveRecord::Migration[7.0]
  def change
    add_reference :companions, :mouth, foreign_key: { to_table: :accessories, on_delete: :nullify }
    add_reference :companions, :eyes, foreign_key: { to_table: :accessories, on_delete: :nullify }
  end
end
