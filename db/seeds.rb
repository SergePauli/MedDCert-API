# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

#---------------------------------------------------------
# This part should contain import references lists (NSI)
# Uses: 'easy_import' from 'nsi_import' lib
#---------------------------------------------------------
require "./db/lib/nsi_import"

TOO_BIG_BULK_SIZE = 10000

puts "Загружаем медорганизации"
mappings = { "id" => "id", "oid" => "oid", "oldOid" => "old_oid", "nameFull" => "name_full", "nameShort" => "name", "parentId" => "parent_id", "deleteDate" => "delete_date", "deleteReason" => "delete_reason", "createDate" => "create_date", "modifyDate" => "modify_date", "organizationType" => "organization_type" }
address_mappings = { "addrRegionId" => "state", "aoidStreet" => "aoGUID", "houseid" => "houseGUID", "postIndex" => "postalCode" }
easy_import("1.2.643.5.1.13.13.11.1461", mappings, nil, ["regionId|#{Rails.configuration.region}|EXACT"]) do |record, params|
  address_params = {}
  one_line_string = ""
  record.each { |column|
    address_params = address_params.merge(address_mappings[column["column"]] => column["value"]) if address_mappings[column["column"]]
    one_line_string += column["value"] if !column["value"].blank? && column["column"] == "addrRegionName"
    one_line_string += ", #{column["value"]}" if !column["value"].blank? && ["prefixArea", "prefixStreet", "house"].include?(column["column"])
    one_line_string += " #{column["value"]}" if !column["value"].blank? && ["areaName", "streetName"].include?(column["column"])
    one_line_string += " корп.#{column["value"]}" if !column["value"].blank? && column["column"] == "building"
    one_line_string += " стр.#{column["value"]}" if !column["value"].blank? && column["column"] == "struct"
  }
  address_params = address_params.merge("streetAddressLine" => one_line_string)
  guid = SecureRandom.uuid
  params = params.merge(guid: guid)
  address_params = address_params.merge(parent_guid: guid)
  params = params.merge(address_attributes: address_params)
end

puts "Загружаем должности медработников"
mappings = { "ID" => "id", "Priority" => "priority", "Name" => "name" }
easy_import("1.2.643.5.1.13.13.99.2.700", mappings)

puts "Загружаем типы уд. документов"
mappings = { "ID" => "id", "PARENT_ID" => "parent_id", "SORT" => "sort", "NAME" => "name", "ACTUAL" => "actual" }
easy_import("1.2.643.5.1.13.13.99.2.48", mappings)

puts "Загружаем причины заболеваемости и смертности (МКБ-10)"
mappings = { "ID" => "id", "SORT" => "sort", "S_NAME" => "s_name", "ICD-10" => "ICD10" }
easy_import("1.2.643.5.1.13.13.11.1489", mappings, TOO_BIG_BULK_SIZE)

puts "Загружаем  внешние причины заболеваемости и смертности  (МКБ-10)"
mappings = { "ID" => "id", "SORT" => "sort", "S_NAME" => "s_name", "ICD-10" => "ICD10" }
easy_import("1.2.643.5.1.13.13.99.2.692", mappings, TOO_BIG_BULK_SIZE)

puts "Загружаем номенклатуру медицинских услуг"
mappings = { "ID" => "id", "S_CODE" => "s_code", "NAME" => "name", "REL" => "rel", "DATEOUT" => "dateout" }
easy_import("1.2.643.5.1.13.13.11.1070", mappings)
#-----------------------------------------------------------------------------
