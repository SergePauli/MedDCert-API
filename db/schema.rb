# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_05_123315) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "address_prints", id: false, comment: "деструкторизированый адрес для печати свидетельства", force: :cascade do |t|
    t.bigint "address_id"
    t.string "region"
    t.string "district"
    t.string "city"
    t.string "town"
    t.string "street"
    t.string "building"
    t.string "flat"
    t.index ["address_id"], name: "index_address_prints_on_address_id"
  end

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "state", limit: 2, null: false, comment: "Код региона в ФНС"
    t.string "streetAddressLine", null: false, comment: "Адресная строка"
    t.uuid "aoGUID", comment: "Идентификатор fias:AOGUID"
    t.uuid "houseGUID", comment: "Идентификатор fias:HOUSEGUID"
    t.string "postalCode", limit: 6, comment: "Почтовый код"
    t.string "code", limit: 25, comment: "код КЛАДР адресного объекта"
    t.uuid "parent_guid", null: false, comment: "Идентификатор родительского элемента"
    t.boolean "actual", comment: "Признак актуальности адреса"
    t.string "house_number", comment: "Номер дома"
    t.string "struct_number", comment: "Строение"
    t.string "building_number", comment: "Корпус"
    t.string "flat_number", comment: "Квартира, помещение, офис"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["actual"], name: "index_addresses_on_actual"
    t.index ["code"], name: "index_addresses_on_code"
    t.index ["parent_guid"], name: "index_addresses_on_parent_guid"
    t.index ["streetAddressLine"], name: "index_addresses_on_streetAddressLine"
  end

  create_table "audits", force: :cascade do |t|
    t.uuid "guid"
    t.integer "action", limit: 2
    t.string "table", limit: 70
    t.string "field", limit: 70
    t.string "detail"
    t.string "before"
    t.string "after"
    t.integer "severity", limit: 2
    t.string "summary"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["action"], name: "index_audits_on_action"
    t.index ["guid"], name: "index_audits_on_guid"
    t.index ["severity"], name: "index_audits_on_severity"
    t.index ["user_id"], name: "index_audits_on_user_id"
  end

  create_table "authenticators", comment: "кто и когда подписал свидетельство", force: :cascade do |t|
    t.string "type", comment: "тип подписи"
    t.datetime "time", comment: "время подписания документа"
    t.bigint "doctor_id", comment: "Doctor ID (информация о лице, подписавшем документ)"
    t.bigint "certificate_id", comment: "ID подписанного документа"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["certificate_id"], name: "index_authenticators_on_certificate_id"
    t.index ["doctor_id"], name: "index_authenticators_on_doctor_id"
    t.index ["type"], name: "index_authenticators_on_type"
  end

  create_table "certificates", comment: "таблица свидетельств", force: :cascade do |t|
    t.date "issue_date", comment: "дата выдачи свидетельства"
    t.bigint "patient_id", comment: "id данных умершего"
    t.bigint "custodian_id", comment: "id медорганизации"
    t.string "series", null: false, comment: "серия свидетельства"
    t.string "number", null: false, comment: "номер свидетельства"
    t.integer "cert_type", limit: 2, null: false, comment: "enum типа свидетельста 1.2.643.5.1.13.13.99.2.19"
    t.string "series_prev", comment: "серия замененного свидетельства"
    t.string "number_prev", comment: "номер замененного свидетельства"
    t.date "eff_time_prev", comment: "дата создания замененного свидетельства"
    t.datetime "death_datetime", comment: "дата и время смерти"
    t.integer "death_year", limit: 2, comment: "год смерти - если неизвестен месяц"
    t.integer "death_month", limit: 2, comment: "месяц смерти - если неизвестен день"
    t.integer "death_day", limit: 2, comment: "день смерти - если неизвестно время"
    t.integer "life_area_type", limit: 2, comment: "enum тип местности проживания 1.2.643.5.1.13.13.11.1042"
    t.integer "death_area_type", limit: 2, comment: "enum тип местности смерти 1.2.643.5.1.13.13.11.1042"
    t.integer "death_place", limit: 2, comment: "enum смерть наступила 1.2.643.5.1.13.13.99.2.20"
    t.integer "marital_status", limit: 2, comment: "enum семейное положение 1.2.643.5.1.13.13.99.2.15"
    t.integer "education_level", limit: 2, comment: "enum образование 1.2.643.5.1.13.13.99.2.166"
    t.integer "social_status", limit: 2, comment: "enum занятость 1.2.643.5.1.13.13.11.1038"
    t.string "policy_OMS", comment: "полис ОМС умершего или представителя"
    t.integer "death_kind", limit: 2, comment: "enum род смерти 1.2.643.5.1.13.13.99.2.21"
    t.datetime "ext_reason_time", comment: "время смерти от внешних причин"
    t.string "ext_reason_description", comment: "Обстоятельства смерти от внешних причин"
    t.integer "established_medic", limit: 2, comment: "enum кто установил причину 1.2.643.5.1.13.13.99.2.22"
    t.integer "basis_determining", limit: 2, comment: "enum основание для уст. причины 1.2.643.5.1.13.13.99.2.23"
    t.integer "traffic_accident", limit: 2
    t.integer "pregnancy_connection", limit: 2
    t.uuid "guid", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reason_ACME", limit: 6
    t.boolean "approval_e_version"
    t.index ["custodian_id"], name: "index_certificates_on_custodian_id"
    t.index ["death_area_type"], name: "index_certificates_on_death_area_type"
    t.index ["death_kind"], name: "index_certificates_on_death_kind"
    t.index ["death_place"], name: "index_certificates_on_death_place"
    t.index ["education_level"], name: "index_certificates_on_education_level"
    t.index ["issue_date"], name: "index_certificates_on_issue_date"
    t.index ["marital_status"], name: "index_certificates_on_marital_status"
    t.index ["number"], name: "index_certificates_on_number"
    t.index ["patient_id"], name: "index_certificates_on_patient_id"
    t.index ["policy_OMS"], name: "index_certificates_on_policy_OMS"
    t.index ["series"], name: "index_certificates_on_series"
    t.index ["social_status"], name: "index_certificates_on_social_status"
  end

  create_table "child_infos", comment: "в случае смерти ребенка", force: :cascade do |t|
    t.bigint "certificate_id"
    t.integer "term_pregnancy", limit: 2, comment: "enum степень доношенности 1.2.643.5.1.13.13.99.2.18"
    t.integer "weight", comment: "вес ребенка в граммах при рождении"
    t.integer "which_account", comment: "каким по счету рожден у матери"
    t.uuid "guid", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["certificate_id"], name: "index_child_infos_on_certificate_id"
    t.index ["guid"], name: "index_child_infos_on_guid"
  end

  create_table "contacts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "telcom_value", comment: "telcom value"
    t.string "telcom_use", comment: "telcom use-attribute"
    t.boolean "main", default: false, null: false, comment: "Признак основного контакта"
    t.uuid "parent_guid", null: false, comment: "Идентификатор родительского элемента"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_guid"], name: "index_contacts_on_parent_guid"
    t.index ["telcom_value"], name: "index_contacts_on_telcom_value"
  end

  create_table "death_reasons", comment: "Причины смерти", force: :cascade do |t|
    t.string "type", comment: "тип причины, обеспечение STI"
    t.bigint "certificate_id", comment: "ссылка на свидетельство"
    t.bigint "diagnosis_id", null: false, comment: "код мкб-10"
    t.datetime "effective_time", comment: "дата возникновения состояния"
    t.integer "years", limit: 2, comment: "длительность состояния, лет"
    t.integer "months", limit: 2, comment: "длительность состояния, месяцев"
    t.integer "weeks", limit: 2, comment: "длительность состояния, недель"
    t.integer "days", limit: 2, comment: "длительность состояния, дней"
    t.integer "hours", limit: 2, comment: "длительность состояния, часов"
    t.integer "minutes", limit: 2, comment: "длительность состояния, минут"
    t.uuid "guid", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["certificate_id"], name: "index_death_reasons_on_certificate_id"
    t.index ["diagnosis_id"], name: "index_death_reasons_on_diagnosis_id"
    t.index ["type"], name: "index_death_reasons_on_type"
  end

  create_table "diagnoses", comment: "справочник МКБ-10", force: :cascade do |t|
    t.string "s_name", comment: "наименование"
    t.integer "sort", comment: "сортировка"
    t.string "ICD10", comment: "код ICD10"
    t.index ["ICD10"], name: "index_diagnoses_on_ICD10"
    t.index ["s_name"], name: "index_diagnoses_on_s_name"
  end

  create_table "doctors", force: :cascade do |t|
    t.uuid "person_id", comment: "person ID"
    t.bigint "organization_id", comment: "Медорганизаия"
    t.bigint "position_id", comment: "должность"
    t.uuid "guid", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guid"], name: "index_doctors_on_guid"
    t.index ["organization_id"], name: "index_doctors_on_organization_id"
    t.index ["person_id"], name: "index_doctors_on_person_id"
    t.index ["position_id"], name: "index_doctors_on_position_id"
  end

  create_table "ext_diagnoses", comment: "МКБ10 том3 внешние причины заболеваемости и смертности", force: :cascade do |t|
    t.string "s_name", comment: "наименование"
    t.integer "sort", comment: "сортировка"
    t.string "ICD10", comment: "код ICD10"
    t.index ["ICD10"], name: "index_ext_diagnoses_on_ICD10"
    t.index ["s_name"], name: "index_ext_diagnoses_on_s_name"
  end

  create_table "external_reasons", comment: "Внешние причины смерти", force: :cascade do |t|
    t.bigint "certificate_id"
    t.bigint "ext_diagnosis_id", null: false, comment: "код мкб-10"
    t.datetime "effective_time", comment: "период времени"
    t.integer "years", limit: 2, comment: "длительность состояния, лет"
    t.integer "months", limit: 2, comment: "длительность состояния, месяцев"
    t.integer "weeks", limit: 2, comment: "длительность состояния, недель"
    t.integer "days", limit: 2, comment: "длительность состояния, дней"
    t.integer "hours", limit: 2, comment: "длительность состояния, часов"
    t.integer "minutes", limit: 2, comment: "длительность состояния, минут"
    t.uuid "guid", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["certificate_id"], name: "index_external_reasons_on_certificate_id"
    t.index ["ext_diagnosis_id"], name: "index_external_reasons_on_ext_diagnosis_id"
  end

  create_table "identities", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "ДУЛы", force: :cascade do |t|
    t.bigint "identity_card_type_id", comment: "тип документа"
    t.string "series", limit: 50, comment: "серия документа"
    t.string "number", limit: 50, comment: "номер документа"
    t.string "issueOrgName", comment: "кем выдан документ"
    t.string "issueOrgCode", limit: 50, comment: "код подразделения"
    t.date "issueDate", comment: "дата выдачи"
    t.uuid "parent_guid", comment: "ID родительского элемента"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["identity_card_type_id"], name: "index_identities_on_identity_card_type_id"
  end

  create_table "identity_card_types", comment: "типы ДУЛов", force: :cascade do |t|
    t.integer "parent_id", limit: 2, comment: "внутренняя иерархия справочника"
    t.string "name"
    t.integer "sort", limit: 2, comment: "поле для сортировки"
    t.binary "actual"
    t.index ["sort"], name: "index_identity_card_types_on_sort"
  end

  create_table "medical_servs", force: :cascade do |t|
    t.string "s_code", comment: "код услуги"
    t.string "name", comment: "наименование"
    t.integer "rel", limit: 2, default: 1
    t.date "dateout"
    t.index ["name"], name: "index_medical_servs_on_name"
    t.index ["s_code"], name: "index_medical_servs_on_s_code"
  end

  create_table "null_flavors", comment: "values for nullFlavor attribute", force: :cascade do |t|
    t.uuid "parent_guid", null: false, comment: "who used that null flavor"
    t.string "parent_attr", null: false, comment: "null attribute"
    t.integer "code", limit: 2, null: false, comment: "enum value of nullFlavor 1.2.643.5.1.13.13.99.2.286"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_guid"], name: "index_null_flavors_on_parent_guid"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "oid", null: false
    t.string "okpo", comment: "код ОКПО"
    t.string "license", comment: "серия и номер лицензии на осуществление медицинской деятельности"
    t.string "license_data", comment: "указание на Федеральную службу по надзору в сфере здравоохранения и дату регистрации лицензии"
    t.string "parent_oid"
    t.string "osp_oid"
    t.string "children_oid"
    t.string "old_oid"
    t.string "name_full", null: false
    t.string "name", null: false
    t.integer "parent_id"
    t.date "create_date"
    t.date "modify_date"
    t.date "delete_date"
    t.string "delete_reason"
    t.integer "organization_type", limit: 2
    t.uuid "guid", null: false
    t.string "sm_code", limit: 2, default: "00", null: false
    t.index ["guid"], name: "index_organizations_on_guid"
    t.index ["oid"], name: "index_organizations_on_oid"
  end

  create_table "participants", comment: "получатели свидетельств и копий", force: :cascade do |t|
    t.bigint "certificate_id", null: false, comment: "Свидетельство"
    t.uuid "person_id", null: false, comment: "ID Персональных данных"
    t.date "receipt_date", comment: "Дата получения свидетельства или копии"
    t.string "description", comment: "Дополнительная информация о получателе"
    t.boolean "original", default: true, null: false, comment: "Признак оригинала"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["certificate_id"], name: "index_participants_on_certificate_id"
    t.index ["person_id"], name: "index_participants_on_person_id"
  end

  create_table "patients", comment: "информация об умершем", force: :cascade do |t|
    t.uuid "person_id", comment: "person ID"
    t.integer "addr_type", limit: 2, comment: "enum тип адреса(проживания, регистрации)"
    t.integer "gender", limit: 2, comment: "пол пациента"
    t.date "birth_date", comment: "дата рождения nullFlavor: ASKU и UNK"
    t.integer "birth_year", limit: 2, comment: "год рождения - если неизвестен месяц"
    t.integer "birth_month", limit: 2, comment: "месяц рождения - если неизвестен день"
    t.bigint "organization_id", comment: "Организация, констатировавшая факт смерти"
    t.uuid "guid", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_patients_on_organization_id"
    t.index ["person_id"], name: "index_patients_on_person_id"
  end

  create_table "people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "person_name_id", null: false, comment: "ФИО"
    t.string "SNILS", comment: "номер СНИЛС"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["SNILS"], name: "index_people_on_SNILS"
    t.index ["person_name_id"], name: "index_people_on_person_name_id"
  end

  create_table "person_names", force: :cascade do |t|
    t.string "family", comment: "фамилия"
    t.string "given_1", comment: "имя"
    t.string "given_2", comment: "отчество"
    t.index ["family"], name: "index_person_names_on_family"
    t.index ["given_1"], name: "index_person_names_on_given_1"
    t.index ["given_2"], name: "index_person_names_on_given_2"
  end

  create_table "positions", comment: "справочник должностей медработников", force: :cascade do |t|
    t.integer "priority"
    t.string "name"
    t.index ["priority"], name: "index_positions_on_priority"
  end

  create_table "procedures", comment: "хирургические процедуры", force: :cascade do |t|
    t.bigint "death_reason_id", null: false, comment: "ссылка на состояние способствующее смерти"
    t.bigint "medical_serv_id", null: false, comment: "код процедуры"
    t.string "text_value", comment: "своя текстовая вариация расшифровки кода"
    t.datetime "effective_time", comment: "период времени"
    t.uuid "guid", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["death_reason_id"], name: "index_procedures_on_death_reason_id"
    t.index ["guid"], name: "index_procedures_on_guid"
    t.index ["medical_serv_id"], name: "index_procedures_on_medical_serv_id"
  end

  create_table "related_subjects", comment: "элементы relatedSubject (данные матери ребенка до года)", force: :cascade do |t|
    t.bigint "certificate_id"
    t.integer "family_connection", limit: 2, default: 1, null: false, comment: "родственик (мать) 1.2.643.5.1.13.13.99.2.14"
    t.bigint "person_name_id", null: false, comment: "ссылка на ФИО-обязательна"
    t.date "birthTime", comment: "дата рождения, @nullFlavor: UNK"
    t.uuid "guid", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["certificate_id"], name: "index_related_subjects_on_certificate_id"
    t.index ["guid"], name: "index_related_subjects_on_guid"
    t.index ["person_name_id"], name: "index_related_subjects_on_person_name_id"
  end

  create_table "tokens", comment: "токены пользователей", force: :cascade do |t|
    t.bigint "user_id", comment: "one user - one session model"
    t.string "refresh_token", comment: "токен обновления"
    t.index ["user_id"], name: "index_tokens_on_user_id"
  end

  create_table "users", comment: "Пользователи системы", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "person_name_id", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.uuid "activation_link", default: -> { "gen_random_uuid()" }, null: false
    t.string "roles", default: "USER", null: false
    t.boolean "activated", default: false, null: false
    t.uuid "guid", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_number", default: 0
    t.integer "login_times"
    t.index ["email"], name: "index_users_on_email"
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["person_name_id"], name: "index_users_on_person_name_id"
  end

  create_table "versions", comment: "версии свидетельств", force: :cascade do |t|
    t.bigint "certificate_id", null: false
    t.integer "version_number", limit: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["certificate_id"], name: "index_versions_on_certificate_id"
  end

end
