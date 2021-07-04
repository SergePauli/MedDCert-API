class CreateObservations < ActiveRecord::Migration[6.1]
  def change
    create_table :observations, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :parent, comment: "ID родительского элемента"
      t.belongs_to :encoded_field, null: false, comment: "элемент code, не пустой"
      t.uuid :value_element, comment: "ID элемента value"
      t.string "xsi:type", :limit => 2, comment: "аттрибут типа для value"
      t.timestamps
    end
  end
end
