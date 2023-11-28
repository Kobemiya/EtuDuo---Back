class RemoveCompanionAccessoryIds < ActiveRecord::Migration[7.0]
  def change
    remove_reference :companions, :face
    remove_reference :companions, :hands
    remove_reference :companions, :hair
    remove_reference :companions, :neck
    remove_reference :companions, :torso
    remove_reference :companions, :legs
    remove_reference :companions, :feet
    remove_reference :companions, :mouth
    remove_reference :companions, :eyes
  end
end
