class CreateChildInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :child_infos, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "в случае смерти ребенка" do |t|
      t.integer :term_pregnancy, limit: 1, comment: "enum степень доношенности 1.2.643.5.1.13.13.99.2.18"
      t.integer :weight, comment: "вес ребенка в граммах при рождении"
      t.integer :which_account, comment: "каким по счету рожден у матери"
      t.timestamps
    end
  end
end
