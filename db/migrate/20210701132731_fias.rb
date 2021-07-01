class Fias < ActiveRecord::Migration[6.1]
  def change
    create_table :fias_elements, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :aoGUID, comment: "Идентификатор fias:AOGUID"
      t.uuid :houseGUID, comment: "Идентификатор fias:HOUSEGUID"
      t.belongs_to :address, index: true, foreign_key: true
    end
  end
end
