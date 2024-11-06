module JiaBo
  module Model::App
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :member_code, :string
      attribute :api_key, :string
      attribute :devices_count, :integer, default: 0
      attribute :templates_count, :integer, default: 0

      has_many :devices, dependent: :destroy_async
    end

    def api
      return @api if defined? @api
      @api = Api::App.new(self)
    end

    def sync_devices
      r = api.list_devices.dig('deviceList')
      r.each do |list|
        device = devices.find_or_initialize_by(device_id: list['deviceID'])
        device.dev_name = list['title']
        device.save
      end
    end

  end
end
