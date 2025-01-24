module JiaBo
  module Model::DeviceOrgan
    extend ActiveSupport::Concern

    included do
      attribute :type, :string
      attribute :default, :boolean, default: true
      attribute :aim, :string
      attribute :ip, :string

      enum :aim, {
        produce: 'produce',
        receipt: 'receipt'
      }, prefix: true

      belongs_to :device, optional: true
      belongs_to :organ, class_name: 'Org::Organ', optional: true

      after_update :set_default, if: -> { default? && saved_change_to_default? }
    end

    def set_default
      self.class.where.not(id: self.id).where(organ_id: self.organ_id).update_all(default: false)
    end

    def print(model, printer_port = 9100)
      sock = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
      sock.connect(Socket.pack_sockaddr_in(printer_port, ip))
      begin
        sock.send(model.to_esc, 0)
        logger.debug "指令已发送到打印机"
      rescue StandardError => e
        logger.debug "发送失败: #{e.message}"
      ensure
        # 关闭连接
        sock.close unless sock.closed?
      end
    end

  end
end
