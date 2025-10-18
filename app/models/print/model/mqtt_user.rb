require 'bcrypt'
module Print
  module Model::MqttUser
    extend ActiveSupport::Concern

    included do
      attribute :username, :string
      attribute :password_hash, :string
      attribute :password, :string
      attribute :is_superuser, :boolean, default: false

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
      ['${clientid}/unregistered', '${clientid}/confirm', 'zonelink/notice'].each do |topic|
        mqtt_acls.find_or_initialize_by(topic: topic) do |acl|
          acl.action = 'subscribe'
        end
      end

      ['cloudPrinter/register', 'cloudPrinter/ready', 'cloudPrinter/exception', 'cloudPrinter/heartbeat'].each do |topic|
        mqtt_acls.find_or_initialize_by(topic: topic) do |acl|
          acl.action = 'publish'
        end
      end
    end

  end
end
