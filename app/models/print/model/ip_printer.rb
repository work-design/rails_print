module Print
  module Model::IpPrinter
    extend ActiveSupport::Concern

    included do
      attribute :ip, :string
      attribute :port, :string

      belongs_to :organ, class_name: 'Org::Organ', optional: true
      has_many :devices, as: :printer
      accepts_nested_attributes_for :devices
    end

    def print
      pr = BaseEsc.new
      esc = yield pr

      sock = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
      sock.connect(Socket.pack_sockaddr_in(9100, ip))
      begin
        r = esc.render_0x
        sock.send(r, 0)
        logger.debug "\e[35m  指令已发送到打印机  \e[0m"
        r
      rescue StandardError => e
        logger.debug "\e[35m  发送失败: #{e.message}  \e[0m"
      ensure
        # 关闭连接
        sock.close unless sock.closed?
      end
    end

  end
end