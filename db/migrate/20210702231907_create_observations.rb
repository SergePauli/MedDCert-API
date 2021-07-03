class CreateObservations < ActiveRecord::Migration[6.1]
  def change
    create_table :observations, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :parent, comment: "ID родительского элемента"
      t.belongs_to :code, class_name: "EncodedField", foreign_key: "code", comment: "Код поля 1.2.643.5.1.13.13.99.2.166"
      t.jsonb :value, comment: "Значение поля в формате JSON"
      t.timestamps
    end
  end
end
