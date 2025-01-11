# frozen_string_literal: true

module JiaBo
  class AppApi < BaseApi
    BASE = 'https://api.poscom.cn/apisc/'

    def list_devices
      post 'listDevice', origin: BASE
    end

    def get_status(device_id)
      post 'getStatus', origin: BASE, deviceID: device_id
    end

  end
end
