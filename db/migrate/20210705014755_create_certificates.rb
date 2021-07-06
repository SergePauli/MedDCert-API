class CreateCertificates < ActiveRecord::Migration[6.1]
  def change
    create_table :certificates, comment: "таблица свидетельств" do |t|
      t.date :eff_time, null: false, comment: "дата создания документа"
      t.belongs_to :patient, index: true, comment: "id данных умершего"
      t.belongs_to :author, object: "Authenticator", index: true, comment: "id данных авторства"
      t.belongs_to :legal_authenticator, object: "Authenticator", comment: "id данных заверителя"
      t.belongs_to :authenticator, object: "Authenticator", comment: "id данных проверяющего"
      t.belongs_to :custodian, object: "Organization", index: true, comment: "id медорганизации"
      t.string :series, null: false, index: true, comment: "серия свидетельства"
      t.string :number, null: false, index: true, comment: "номер свидетельства"
      t.integer :cert_type, null: false, limit: 1, comment: "enum типа свидетельста 1.2.643.5.1.13.13.99.2.19"
      t.string :series_prev, comment: "серия замененного свидетельства"
      t.string :number_prev, comment: "номер замененного свидетельства"
      t.date :eff_time_prev, null: false, comment: "дата создания документа"
      #t.text :docinfo_text, comment: "секция docinfo 'техт'"
      t.datetime :death_datetime, comment: "дата и время смерти"
      t.integer :death_year, limit: 2, comment: "год смерти - если неизвестен месяц"
      t.integer :death_month, limit: 1, comment: "месяц смерти - если неизвестен день"
      t.integer :death_day, limit: 2, comment: "день смерти - если неизвестно время"
      t.uuid :life_addr, index: true, comment: "место жительства"
      t.integer :life_area_type, limit: 1, comment: "enum тип местности проживания 1.2.643.5.1.13.13.11.1042"
      t.uuid :death_addr, index: true, comment: "место смерти"
      t.integer :death_area_type, index: true, limit: 1, comment: "enum тип местности смерти 1.2.643.5.1.13.13.11.1042"
      t.integer :death_place, index: true, limit: 1, comment: "enum смерть наступила 1.2.643.5.1.13.13.99.2.20"
      t.integer :marital_status, index: true, limit: 1, comment: "enum семейное положение 1.2.643.5.1.13.13.99.2.15"
      t.integer :education_level, index: true, limit: 1, comment: "enum образование 1.2.643.5.1.13.13.99.2.166"
      t.integer :social_status, index: true, limit: 1, comment: "enum занятость 1.2.643.5.1.13.13.11.1038"
      t.string :policy_OMS, index: true, comment: "полис ОМС умершего или представителя"
      t.integer :death_kind, index: true, limit: 1, comment: "enum род смерти 1.2.643.5.1.13.13.99.2.21"
      t.datetime :ext_reason_time, comment: "время смерти от внешних причин"
      t.integer :established_medic, null: false, limit: 1, comment: "enum кто установил причину 1.2.643.5.1.13.13.99.2.22"
      t.integer :basis_determining, null: false, limit: 1, comment: "enum основание для уст. причины 1.2.643.5.1.13.13.99.2.23"
      t.belongs_to :a_reason, class_name: "DeathReason", comment: "а) Болезнь или состояние, напосредственно приведшее к смерти"
      t.belongs_to :b_reason, class_name: "DeathReason", comment: "б) Патологическое состояние, которое привело к возникновению вышеуказанной причины"
      t.belongs_to :c_reason, class_name: "DeathReason", comment: "в) первоначальная причина смерти"
      t.belongs_to :d_reason, class_name: "DeathReason", comment: "г) внешняя причина при травмах и отравлениях"
      t.uuid :guid, index: true, null: false, default: -> { "gen_random_uuid()" }, unique: true
      t.timestamps
    end
  end
end
