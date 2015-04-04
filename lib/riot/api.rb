require 'fileutils'
require 'rest_client'
require 'addressable/uri'


module Riot
  class Api
    # DO NOT COMMIT THIS
    API_KEY = 'dd59f117-bdbe-4d59-af22-9c3ebfb97e3b'
    PATH = "/code/riot/data"

    attr_reader :region, :host

    def initialize(region = :na)
      @region = region.to_s
      @host = "https://#{@region}.api.pvp.net/api/lol/"
    end

    def api_challenge(epoch, region = 'na')
      url = build_url("v4.1/game/ids?beginDate=#{epoch}")
      result = execute_and_save!(:api_challenge, epoch, url)
      JSON.parse(result)
    end

    def match(id, region = 'na')
      url = build_url("v2.2/match/#{id}?includeTimeline=true")
      execute_and_save!(:match, id, url)
    end

    def execute_and_save!(type, id, url)
      target = File.join(PATH, type.to_s, region.to_s, "#{id}.json")
      return File.read(target) if File.exist?(target)

      result = execute!(url)
      FileUtils.mkdir_p(File.join(PATH, type.to_s, region.to_s))
      File.open(target, 'w') do |f|
        f.write(result)
      end

      return result
    end

    def build_url(url)
      path = ::Addressable::URI.join(host, "#{region}/", url)
      uri = ::Addressable::URI.parse(path)
      uri.query_values = (uri.query_values || {}).merge({api_key: API_KEY})
      uri.to_s
    end

    def execute!(url)
      puts "Calling #{url}"
      result = RestClient::Request.execute(
          method: :get,
          url: url,
          content_type: :json,
          accept: :json,
          timeout: nil,
          open_timeout: 30
        )
      # can't make more than 10 queries 10 seconds or 500 queries in 600 sec
      sleep(1.2)
      return result
    end
  end
end

