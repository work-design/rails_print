module Print
  module Model::MqttPrinter
    extend ActiveSupport::Concern
    PREFIX = '1E 10'

    included do
      attribute :dev_imei, :string, index: true
      attribute :dev_type, :string
      attribute :dev_vendor, :string
      attribute :dev_network, :string
      attribute :dev_tel, :string
      attribute :dev_spec, :string
      attribute :dev_cut, :boolean
      attribute :dev_desc, :string
      attribute :dev_ip, :string
      attribute :online, :boolean
      attribute :extra, :json, default: {}

      #belongs_to :mqtt_app
    end

    def assign_info(payload)
      infos = payload.split('#')

      self.extra = {
        '终端类型' => infos[0],
        '注册期限' => infos[3],
        '方案提供商编号' => infos[4],
        '方案编号' => infos[6],
        '版本序号' => infos[7],
        '版本描述' => infos[8]
      }
      self.dev_vendor = infos[2]
      self.dev_network = infos[5]
      self.dev_tel = infos[9]
      self.dev_spec = infos[10]
      self.dev_cut = infos[11]
    end

    def api
      return @api if defined? @api
      @api = $mqtt_user.api
    end

    def register_success
      api.publish "#{dev_imei}/unregistered", 'registerSuccess', false, 2
    end

    def register_401
      api.publish "#{dev_imei}/unregistered", 'registerFail@401', false, 2
    end

    def confirm(payload, kind: 'ready')
      _, id = payload.split('#')
      api.publish "#{dev_imei}/confirm", "#{kind}##{id}", false, 2
    end

    def print()
      r = [PREFIX, '00 00 00 11 04 31 30 30 31 00 00 00 04 41 42 43 44 1B 63 2d 32'].join(' ')
      api.publish dev_imei, r, false, 2
    end

  end
end
