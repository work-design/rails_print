module JiaBo
  module Model::Device
    extend ActiveSupport::Concern
    BASE = 'https://api.poscom.cn/apisc/'

    included do
      attribute :device_id, :string
      attribute :dev_name, :string
      attribute :grp_id, :string
      attribute :dev_id, :string

      belongs_to :app, counter_cache: true
      has_many :device_organs, dependent: :delete_all

      after_create_commit :add_to_jia_bo
    end

    def print(msg_no: nil, data: nil, mode: 2, cmd_type: 'TSPL', reprint: 0, multi: 0)
      _api = Api::DeviceMsg.new(self)
      params = {
        mode: mode,
        charset: 1,
        cmdType: cmd_type,
        msgDetail: data,
        reprint: reprint,
        multi: multi
      }
      params.merge! msgNo: msg_no if msg_no.present?

      r = _api.msg params
      logger.debug "\e[35m  #{r}  \e[0m"
      r
    end

    def get_status
      app.api.get_status(device_id)
    end

    # 取值范围 0-100，建议(0,25,50,75, 85,100)。
    def send_volume(level = 20)
      api.send_volume level
    end

    def info
      r = api_new.info
      r['code'] == 0 ? r['msg'] : r
    end

    def cancel_print
      api.cancel_print(all: 1)
    end

    def add_to_jia_bo
      result = api.add_dev devName: id
      self.update dev_id: result['devID'] if result['code'] == 1
      result
    end

    def remove_from_jia_bo
      r = api.del_dev
      if r['code'] == 1
        self.update dev_id: nil
      end
    end

    def approved?
      dev_id.present?
    end

    def print_esc
      es = BaseEsc.new
      es << "Some text"
      es << EscHelper.quad_text("Big text")
      es << "Some text"
      es << EscHelper.quad_text("Big text")
      x = es.render
      print(
        data: "#{x}Oa0a0a0a",
        mode: 3,
        cmd_type: 'ESC'
      )
      es
    end

    def print_tspl
      ts = BaseTspl.new
      ts.bar(height: 20)
      ts.qrcode('xx', x: 20, y: 30, cell_width: 5)
      ts.text('ddd', x: 320, scale: 2)
      ts.middle_text('订单详情', x: 320)

      #print( data: ts.render, cmd_type: 'TSPL')
      ts.render
    end

    def api
      return @api if defined? @api
      @api = Api::Device.new(self)
    end

    def api_new
      return @api_new if defined? @api_new
      @api_new = Api::DeviceNew.new(self)
    end

  end
end
