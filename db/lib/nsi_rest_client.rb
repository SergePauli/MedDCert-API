# This is rest-client for nsi.rosminzdrav.ru

require "rest-client"
# заголовки в запросе
HEADERS = { content_type: :json, accept: :json }.freeze
# Параметры подключения к НСИ сервису
BASE = "https://nsi.rosminzdrav.ru:443/port/rest/data?userKey=".freeze
USERKEY = Rails.configuration.nsi_token.freeze

# launching a GET request to the rest service of nsi.rosminzdrav.ru
# param identifier - OID of reference list like '1.2.643.5.1.13.13.99.2.206'
# param page - row offset in list
# param size - limit of rows per page
# param filters -array of strings: FIELDNAME|VALUE|EXACT or LIKE
def run_query(identifier, page = nil, size = nil, filters = nil)
  raise Exception.new("identifier param need to be present!") if identifier.blank?
  url_string = BASE + USERKEY + "&identifier=#{identifier}"
  url_string += "&page=#{page.to_s}" if !page.blank?
  url_string += "&size=#{size.to_s}" if !size.blank?
  filters.each do |filter|
    url_string += "&filters=#{filter}"
  end if !filters.blank?
  r = RestClient.get url_string, HEADERS
  return JSON.parse(r)
end
