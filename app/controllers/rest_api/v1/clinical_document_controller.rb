require "nsi_constant.rb"
# контроллер выдачи CDA формы свидетельства о смерти
# взрослого
class RestApi::V1::ClinicalDocumentController < RestApi::DocumentController
  skip_before_action :prepare_data, only: :mdc_xsl

  def adult
    if @certificate.version.blank?
      @certificate.version = Version.new(version_number: 1)
      @certificate.save
    end
    render "clinical_document/create", layout: "clinical_document", formats: :xml
  end

  def mdc_xsl
    render file: "#{Rails.root}/public/MDC.xsl", layout: false
  end

  private

  def prepare_data
    find_record
    @time_zone = DateTime.now.to_s.slice(-6, 6).gsub(":", "")
    @number = @certificate.number
    @issueDate = @certificate.issue_date || Date.today()
    @patient = @certificate.patient
    @patient_OMS_nullFlavor = @patient.nullFlavor("policy_OMS") || "UNK" unless @certificate.policy_OMS
    @death_addr_nullFlavor = @patient.nullFlavor("death_addr") || "UNK" unless @certificate.death_addr
    @ext_time_nullFlavor = @certificate.nullFlavor("ext_reason_time") || "NA" unless @certificate.ext_reason_time
    @ext_description_nullFlavor = @certificate.nullFlavor("ext_reason_description") || "NA" unless @certificate.ext_reason_description
    @root = "#{@certificate.custodian.oid}.100.#{Rails.configuration.number_MIS}.#{Rails.configuration.number_MIS_instance}"
    if @patient.person
      @person = @patient.person
      @patient_FIO = @person.person_name
      @patient_address = @person.address
      @patient_address_nullFlavor = @person.nullFlavor("address") || "UNK" unless @person.address
      @snils = @person.SNILS.gsub(" ", "").gsub("-", "") if @person.SNILS
      @snils_nullFlavor = @person.nullFlavor("SNILS") || "UNK" unless @snils
    else
      @patient_person_nullFlavor = @patient.nullFlavor("person") || "NA"
    end
    if @patient.identity
      @identity = @patient.identity
      raise ApiCdaError.new("Ошибка полноты данных: номер ДУЛ умершего отсутствует", :unprocessable_entity) unless @identity.number
      raise ApiCdaError.new("Ошибка полноты данных: дата выдачи ДУЛ умершего отсутствует", :unprocessable_entity) unless @identity.issueDate
      @patient_series_nullFlavor = @identity.nullFlavor("series") || "NA" unless @identity.series
      @patient_issueOrgName_nullFlavor = @identity.nullFlavor("issueOrgName") || "NA" unless @identity.issueOrgName
      @patient_issueOrgCode_nullFlavor = @identity.nullFlavor("issueOrgCode") || "NA" unless @identity.issueOrgCode
    else
      @patient_identity_nullFlavor = @patient.nullFlavor("identity") || "UNK"
    end
  end
end
