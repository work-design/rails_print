module Print
  module Model::IpPrinter
    extend ActiveSupport::Concern

    included do
      attribute :ip, :string
      attribute :port, :string
    end

    def print(esc)
      sock = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
      sock.connect(Socket.pack_sockaddr_in(9100, ip))
      begin
        sock.send(esc.render_0x, 0)
        logger.debug '指令已发送到打印机'
      rescue StandardError => e
        logger.debug "发送失败: #{e.message}"
      ensure
        # 关闭连接
        sock.close unless sock.closed?
      end
    end

  end
end