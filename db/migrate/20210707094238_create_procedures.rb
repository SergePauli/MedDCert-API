class CreateProcedures < ActiveRecord::Migration[6.1]
  def up
    create_table :procedures, comment: "хирургические процедуры" do |t|
      t.belongs_to :death_reason, null: false, comment: "ссылка на состояние способствующее смерти"
      t.belongs_to :medical_serv, null: false, comment: "код процедуры"
      t.string :text_value, comment: "своя текстовая вариация расшифровки кода"
      t.datetime :effective_time, comment: "период времени"
      t.uuid :guid, index: true, null: false, default: -> { "gen_random_uuid()" }, unique: true
      t.timestamps
    end
  end

  def down
    drop_table :procedures
  end
end
