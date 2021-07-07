class CreateIdentityCardTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :identity_card_types, comment: "типы ДУЛов" do |t|
      t.integer :parent_id, limit: 2, comment: "внутренняя иерархия справочника"
      t.string :name
      t.integer :sort, index: true, :limit => 2, comment: "поле для сортировки"
      t.binary :actual
    end
  end
end
