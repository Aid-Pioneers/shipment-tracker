require 'uri'
require 'open-uri'

module ApplicationHelper
  def authentic_scans(id)
    res = URI.parse("https://api.authentic.network/api/v2/items/#{id}/scans")
    unless res.is_a?(Net::HTTPSuccess)
      flash[:error] = 'Authentic API error'
      return []
    end
    result = JSON.parse(res.read)

    result['scans'].map do |scan|
      data = scan['data']
      Scan.new(date: DateTime.parse(data['timestamp']),
               location: Geocoder.search([data['location']['_lat'], data['location']['_long']]).first.address,
               sticker_destroyed: data['copyclassification'] != 'original')
    end
  end
end
