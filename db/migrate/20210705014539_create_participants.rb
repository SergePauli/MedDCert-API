class CreateParticipants < ActiveRecord::Migration[6.1]
  def up
    create_table :participants, comment: "получатели свидетельств и копий" do |t|
      t.belongs_to :certificate, index: true, null: false, comment: "Свидетельство"
      t.uuid :person_id, index: true, null: false, comment: "ID Персональных данных"
      t.date :receipt_date, comment: "Дата получения свидетельства или копии"
      t.string :description, comment: "Дополнительная информация о получателе"
      t.boolean :original, null: false, :default => true, comment: "Признак оригинала"
      t.timestamps
    end
  end

  def down
    drop_table :participants
  end
end
