class CreateCodeSystems < ActiveRecord::Migration[6.1]
  def change
    create_table :code_systems, primary_key: "id", id: :string, comment: "Справочник справочников" do |t|
      t.string :name
      t.string :version, :limit => 10
    end
  end
end
