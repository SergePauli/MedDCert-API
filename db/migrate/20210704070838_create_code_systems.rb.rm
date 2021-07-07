class CreateCodeSystems < ActiveRecord::Migration[6.1]
  def change
    create_table :code_systems, primary_key: "id", id: :string, comment: "Справочник справочников" do |t|
      t.string :name, comment: "Наименование справочника"
      t.string :version, :limit => 10, comment: "Версия справочника"
      t.string :model_name, comment: "Имя модели, представляющей справочник"
    end
  end
end
