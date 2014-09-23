# coding: utf-8
require 'typhoeus'

module Java

  HOST = "http://114.215.131.133/api.aspx?"

  
 
  class Base
    attr_accessor :json, :items, :response

    def initialize(method, url, params = {}, body={}, opt={})
      options={
        method: method,
        headers: {"Content-Type" => "application/json",
          "Accept"=>"application/json;charset=utf-8",
          "User-Agent"=>"Mozilla/5.0 (X11; Linux x86_64; rv:2.0.1) Gecko/20100101 Firefox/4.0.1"},
        timeout: 9000, # milliseconds
        params: params
      }

      options[:body] = body.to_json if body.present?

      #调用其他地址的接口时， 可以在params中传入{:host => "true"}
      request_url = (opt[:host] == "true" ? url : "#{HOST}#{url}")
      request = Typhoeus::Request.new(request_url,options)
      request.on_complete do |response|
        if response.success?
          @json = response.body.start_with?("{") || response.body.start_with?("[{")  ? $json.decode(response.body) : nil
        elsif response.timed_out?
          #$java_logger.info("timeout url:#{request_url} time:#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}") if $java_logger.present?
        else
          Logger.new(STDOUT).info("response code: #{response.code}")
        end
      end


      hydra = Typhoeus::Hydra.new

      hydra.queue(request)
      hydra.run

      @response = request.response
      
    rescue Errno::ECONNREFUSED, Errno::ENETUNREACH, Errno::ETIMEDOUT
      raise ServerDownError
    end

    ############ 接口访问 ##########
    def self.get(url, params = {:time => Time.now}, opt={})
      Base.new(:get, url, params, {}, opt)
    end
    
    def self.head(url, params = {:time => Time.now}, opt={})
      Base.new(:head, url, params, {}, opt)
    end

    def self.post(url, params = {}, body={}, opt={})
      Base.new(:post, url, params, body, opt)
    end

    def self.put(url, params = {}, body={}, opt={})
      Base.new(:put, url, params, body, opt)
    end

    def self.delete(url, params = {})
      Base.new(:delete, url, params)
    end

    ############ 状态判断 ##########
    # 是否成功
    def success?
      @response.success?
    end

    # 是否是单条数据
    def single?
      @json.present? and @json.is_a?(Hash)
    end

    # 取返回状态
    def status
      @response.code
    end
    
    # 取返回body
    def body
      {result: @response.body}
    end

    def id
      @json["id"] rescue nil
    end

  end

end
