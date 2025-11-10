module Print
  module Model::MqttPrinter
    extend ActiveSupport::Concern
    PREFIX = ['1E', '10']
    TAG = ['1B', '63']

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

    def print_pos(text = '')
      pr = BaseEsc.new
      pr.text(text)

      payload = pr.render
      print(payload)
    end

    def print(payload, task: '1001')
      task_bytes = task.bytes.map(&:to_16_str)
      task_size = task_bytes.size.to_16_str
      payload_bytes = payload.map(&:to_16_str)
      payload_size = [payload_bytes.size].pack('N').bytes.map(&:to_16_str)
      x = Crc16Util.check(payload_bytes)
      check = [x].pack('n').bytes.map(&:to_16_str)

      all = [task_size] + task_bytes + payload_size + payload_bytes + TAG + check
      all_size = [all.size].pack('N').bytes.map(&:to_16_str)

      r = (PREFIX + all_size + all).map(&:upcase).join(' ')
      logger.debug "The Str: #{r}"

      api.publish dev_imei, r, false, 2
      r
    end

  end
end
