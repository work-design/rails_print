module Print
  module Model::JiaBoApp
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :member_code, :string
      attribute :api_key, :string
      attribute :jia_bo_printers_count, :integer, default: 0

      has_many :jia_bo_printers, dependent: :destroy_async
    end

    def api
      return @api if defined? @api
      @api = Jiabo::AppApi.new(self)
    end

    def sync_devices
      r = api.list_devices.dig('deviceList')
      r.each do |list|
        device = jia_bo_printers.find_or_initialize_by(device_id: list['deviceID'])
        device.dev_name = list['title']
        device.save
      end
    end

  end
end
