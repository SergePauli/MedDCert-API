# This is rest-client for FIAS API
require "rest-client"
require "nsi_constant.rb"

class RestApi::V1::PrintController < RestApi::DocumentController
  #before_action :authenticate_request
  #attr_reader :current_user

  # GET /REST_API/v1/print/face/:id
  def face
    @is_death_time = @certificate.nullFlavor("death_time") ? false : true
    @is_ext_time = @certificate.ext_reason_time ? @certificate.ext_reason_time.hour != 0 || @certificate.ext_reason_time.min != 0 : false
    @month = age_month
    if @certificate.patient.person && @certificate.patient.person.address
      adr = @certificate.patient.person.address
      @address = copy_address(adr)
      result = request_address_info(adr.aoGUID, adr.houseGUID ? "building" : "")
      if result && result["data"] && result["data"].length > 0
        parse_address_info(result["data"][0])
        @regAddress = @address.dup
      else
        @regAddress = copy_address
        @regAddress[:nullFlavor] = "ОШИБКА В АДРЕСЕ"
      end
    elsif @certificate.patient.person
      @regAddress = copy_address
      @regAddress[:nullFlavor] = "НЕИЗВЕСТНО"
    else
      @regAddress = copy_address
      @regAddress[:nullFlavor] = "НЕПРИМЕНИМО"
    end
    adr = @certificate.death_addr
    if adr
      @address = copy_address(adr)
      result = request_address_info(adr.aoGUID, adr.houseGUID ? "building" : "")
      if result && result["data"] && result["data"].length > 0
        parse_address_info(result["data"][0])
        @deathAddress = @address.dup
      else
        @deathAddress = copy_address
        @deathAddress[:nullFlavor] = "ОШИБКА В АДРЕСЕ"
      end
    else
      @deathAddress = copy_address
      @deathAddress[:nullFlavor] = "НЕИЗВЕСТНО"
    end
    adr = @certificate.child_info && @certificate.child_info.address
    if adr
      @address = copy_address(adr)
      result = request_address_info(adr.aoGUID, adr.houseGUID ? "building" : "")
      if result && result["data"] && result["data"].length > 0
        parse_address_info(result["data"][0])
        @childAddress = @address.dup
      else
        @childAddress = copy_address
        @childAddress[:nullFlavor] = "ОШИБКА В АДРЕСЕ"
      end
    elsif @certificate.child_info
      @childAddress = copy_address
      @childAddress[:nullFlavor] = "НЕИЗВЕСТНО"
    else
      @childAddress = copy_address
      @childAddress[:nullFlavor] = "НЕПРИМЕНИМО"
    end
    mother_info
    render "print/face", layout: "print"
  end

  # GET /REST_API/v1/print/back/:id
  def back
    render "print/back", layout: "print"
  end

  private

  def age_days
    return "" if @certificate.patient.birth_date.blank? || @certificate.death_datetime.blank?
    @d_day = Date.parse(@certificate.death_datetime.to_s)
    @b_day = @certificate.patient.birth_date
    days = (@d_day - @b_day).to_i
    return "" if days > 366 # only for child < 1 year
    return days
  end

  def age_month
    @days = age_days
    return "" if @days.blank?
    return "" if @days < 30
    if (@d_day.year > @b_day.year)
      return @d_day.month + (12 - @b_day.month)
    else
      return @d_day.month - @b_day.month
    end
  end

  def mother_info
    @mother_birthday = @certificate.child_info &&
                       @certificate.child_info.related_subject &&
                       @certificate.child_info.related_subject.birthTime
    @mother_name = @certificate.child_info &&
                   @certificate.child_info.related_subject &&
                   @certificate.child_info.related_subject.name
    if @days.blank? || @days > 30 || @mother_birthday.blank?
      @mother_age = ""
    else
      @mother_age = Date.today.year - @mother_birthday.year
    end
  end

  def request_address_info(parent, level)
    # заголовки в запросе
    headers = { content_type: :json, accept: :json }
    # Параметры подключения к ФИАС сервису
    url_string = "#{Rails.configuration.fias_url}?parent=#{parent}&withParent=1&level=#{level}&limit=1"
    r = RestClient::Request.execute(method: :get, url: url_string, headers: headers)
    return JSON.parse(r)
  end

  def copy_address(address = nil)
    {
      nullFlavor: false, region: "", district: "", city: "", town: "",
      street: "", house_number: address && address.house_number || "", struct_number: address && address.struct_number || "", building_number: address && address.building_number || "", flat_number: address && address.flat_number || "",
    }
  end

  def parse_address_info(fias_item)
    case fias_item["level"]
    when "Street"
      @address[:street] = "#{fias_item["name"]} #{(fias_item["shortname"].include? "ул") ? "" : fias_item["shortname"]}"
    when "Town"
      @address[:town] = "#{fias_item["shortname"]} #{fias_item["name"]}"
    when "City"
      @address[:city] = fias_item["name"]
    when "District"
      @address[:district] = fias_item["name"]
    when "Region"
      @address[:region] = "#{fias_item["name"]} #{fias_item["shortname"]}"
    end
    parse_address_info(fias_item["parent"]) if fias_item["parent"]
  end
end
