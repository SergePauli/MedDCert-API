class CreateEncodedFields < ActiveRecord::Migration[6.1]
  def change
    create_table :encoded_fields, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "значения всех кодируемых полей" do |t|
      t.belongs_to :code_system, null: false, index: true, comment: "ссылка на справочник"
      t.string :code, null: false, index: true, :limit => 40, comment: "код значения"
      t.string :displayName, null: false, comment: "отображаемое имя значения"
    end
  end
end
