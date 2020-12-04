require 'date'
require 'faraday'

class IGlucoseApi
  def initialize(api_key = nil)
    self.api_key = api_key || ENV.fetch('IGLUCOSE_API_KEY')
  end

  def get_measurements(start_date = nil, end_date = nil, device_ids = nil)
    uri = "#{ENV['IGLUCOSE_API_ENDPOINT']}/readings/"
    params = {
      api_key: api_key,
      date_start: start_date || default_start_time,
      date_end: end_date || default_end_time
    }
    params.merge!(meter_ids: device_ids) if device_ids.present?
    response = Faraday.post(uri, params.to_json, {'Accept' => 'application/json'})
    JSON.parse(response.body).merge(status: response.status)
  end

  def create_fulfillment_order(payload)
    uri = "#{ENV['IGLUCOSE_API_ENDPOINT']}/fulfillment/?api_key=#{api_key}"
    response = Faraday.post(uri, payload.to_json, {'Accept' => 'application/json'})
    JSON.parse(response.body).merge(status: response.status)
  end

  def get_order_status(payload)
    uri = "#{ENV['IGLUCOSE_API_ENDPOINT']}/fulfillment/number"
    params = payload.merge(api_key: api_key)
    response = Faraday.get(uri, params, {'Accept' => 'application/json'})
    JSON.parse(response.body).merge(status: response.status)
  end

  private
  attr_accessor :api_key

  def default_start_time
    Date.today.prev_day.strftime('%Y-%m-%dT00:00:00')
  end
  
  def default_end_time
    Date.today.strftime('%Y-%m-%dT23:59:59')
  end
end
