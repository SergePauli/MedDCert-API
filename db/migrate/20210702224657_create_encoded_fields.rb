class CreateEncodedFields < ActiveRecord::Migration[6.1]
  def change
    create_table :encoded_fields do |t|
      t.string :name
    end
  end
end
