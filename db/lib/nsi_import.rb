require "./db/lib/nsi_rest_client"

MODEL_OID = {
  "1.2.643.5.1.13.13.99.2.700" => "Position",
  "1.2.643.5.1.13.13.99.2.48" => "IdentityCardType",
  "1.2.643.5.1.13.13.11.1489" => "Diagnosis",
  "1.2.643.5.1.13.13.99.2.692" => "ExtDiagnosis",
  "1.2.643.5.1.13.13.11.1070" => "MedicalServ",
  "1.2.643.5.1.13.13.11.1461" => "Organization",
}

def easy_import(references_list_oid, mappings, bulk_size = 1000, filters = nil)
  @model_class = MODEL_OID[references_list_oid].constantize
  raise "Model class is not ActiveRecord" unless @model_class < ActiveRecord::Base
  if @model_class.count.zero?
    passed = 0
    page = 1
    loop do
      data = run_query(references_list_oid, page, bulk_size, filters)
      if (data["list"].length > 0)
        records = []
        data["list"].each do |record|
          params = {}
          # сопоставление полей, имеющих иное название в модели
          # field mappings, which you need to import
          record.each { |field| params = params.merge(mappings[field["column"]] => field["value"]) if mappings[field["column"]] }
          records.push(@model_class.new params)
          passed += 1
        end
        # bulk insertion with activerecord-import gem
        @model_class.import records
        puts "OID #{references_list_oid} comleted: #{passed} in #{data["total"]}"
        page += 1
      else
        break
      end
    end
  end
end
