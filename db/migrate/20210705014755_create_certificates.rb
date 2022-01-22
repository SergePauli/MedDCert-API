class CreateCertificates < ActiveRecord::Migration[6.1]
  def up
    create_table :certificates, comment: "таблица свидетельств" do |t|
      t.date :issue_date, index: true, comment: "дата выдачи свидетельства"
      t.belongs_to :patient, index: true, comment: "id данных умершего"
      t.belongs_to :custodian, object: "Organization", index: true, comment: "id медорганизации"
      t.string :series, null: false, index: true, comment: "серия свидетельства"
      t.string :number, null: false, index: true, comment: "номер свидетельства"
      t.integer :cert_type, null: false, limit: 1, comment: "enum типа свидетельста 1.2.643.5.1.13.13.99.2.19"
      t.string :series_prev, comment: "серия замененного свидетельства"
      t.string :number_prev, comment: "номер замененного свидетельства"
      t.date :eff_time_prev, comment: "дата создания замененного свидетельства"
      #t.text :docinfo_text, comment: "секция docinfo 'техт'"
      t.datetime :death_datetime, comment: "дата и время смерти"
      t.integer :death_year, limit: 2, comment: "год смерти - если неизвестен месяц"
      t.integer :death_month, limit: 1, comment: "месяц смерти - если неизвестен день"
      t.integer :death_day, limit: 2, comment: "день смерти - если неизвестно время"
      t.integer :life_area_type, limit: 1, comment: "enum тип местности проживания 1.2.643.5.1.13.13.11.1042"
      t.integer :death_area_type, index: true, limit: 1, comment: "enum тип местности смерти 1.2.643.5.1.13.13.11.1042"
      t.integer :death_place, index: true, limit: 1, comment: "enum смерть наступила 1.2.643.5.1.13.13.99.2.20"
      t.integer :marital_status, index: true, limit: 1, comment: "enum семейное положение 1.2.643.5.1.13.13.99.2.15"
      t.integer :education_level, index: true, limit: 1, comment: "enum образование 1.2.643.5.1.13.13.99.2.166"
      t.integer :social_status, index: true, limit: 1, comment: "enum занятость 1.2.643.5.1.13.13.11.1038"
      t.string :policy_OMS, index: true, comment: "полис ОМС умершего или представителя"
      t.integer :death_kind, index: true, limit: 1, comment: "enum род смерти 1.2.643.5.1.13.13.99.2.21"
      t.datetime :ext_reason_time, comment: "время смерти от внешних причин"
      t.string :ext_reason_description, comment: "Обстоятельства смерти от внешних причин"
      t.integer :established_medic, limit: 1, comment: "enum кто установил причину 1.2.643.5.1.13.13.99.2.22"
      t.integer :basis_determining, limit: 1, comment: "enum основание для уст. причины 1.2.643.5.1.13.13.99.2.23"
      t.integer :traffic_accident, limit: 1, commet: "Cвязь с ДТП 1.2.643.5.1.13.13.99.2.24"
      t.integer :pregnancy_connection, limit: 1, commet: "Связь беременностью 1.2.643.5.1.13.13.99.2.25 "
      t.uuid :guid, unique: true, null: false, default: -> { "gen_random_uuid()" }
      t.timestamps
    end
  end

  def down
    drop_table :certificates
  end
end
