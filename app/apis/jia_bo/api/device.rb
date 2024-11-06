# frozen_string_literal: true

module JiaBo::Api
  class Device < Base
    BASE = 'https://api.poscom.cn/apisc/'

    def send_volume(level)
      post 'sendVolume', origin: BASE, volume: level
    end

    def cancel_print(params)
      post 'cancelPrint', origin: BASE, **params
    end

    def add_dev(params)
      post 'adddev', origin: BASE, **params
    end

    def del_dev
      post 'deldev', origin: BASE
    end

    private
    def with_access_token(params: {}, headers: {}, tries: 2)
      params.merge!(
        reqTime: (Time.current.to_f * 1000).round.to_s,
        memberCode: @app.app.member_code,
        deviceID: @app.device_id
      )
      params.merge! securityCode: Digest::MD5.hexdigest([params[:memberCode], params[:reqTime], @app.app.api_key, @app.device_id].join)
      yield
    end

  end
end
