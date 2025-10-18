require 'bcrypt'
module Print
  module Model::MqttUser
    extend ActiveSupport::Concern

    included do
      attribute :username, :string
      attribute :password_hash, :string
      attribute :password, :string

      has_many :mqtt_acls, primary_key: :username, foreign_key: :username

      before_create :init_acls
    end

    def set_pass!(pass = password, cost: 10)
      self.password_hash = BCrypt::Password.create(pass, cost: cost)
      self.save
    end

    def api
      return @api if defined? @api
      @api = MQTT::Client.connect(
        host: 'work_design-emqx',
        username: username,
        password: password
      )
    end

    def init_acls
      mqtt_acls.build(topic: '${clientid}/unregistered', action: 'subscribe')
      mqtt_acls.build(topic: '${clientid}/confirm', action: 'subscribe')
      mqtt_acls.build(topic: 'zonelink/notice', action: 'subscribe')
      mqtt_acls.build(topic: 'cloudPrinter/register', action: 'publish')
      mqtt_acls.build(topic: 'cloudPrinter/ready', action: 'publish')
      mqtt_acls.build(topic: 'cloudPrinter/exception', action: 'publish')
    end

  end
end
