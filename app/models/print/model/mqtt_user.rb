require 'bcrypt'
module Print
  module Model::MqttUser
    extend ActiveSupport::Concern

    included do
      attribute :username, :string
      attribute :password_hash, :string
      attribute :password, :string
    end

    def set_pass!(password, cost: 10)
      self.password_hash = BCrypt::Password.create(password, cost: cost)
      self.save
    end

    def api
      return @api if defined? @api
      @api = MQTT::Client.connect(
        host: 'work_design-emqx',
        port: 5,
        username: username,
        password: password
      )
    end

  end
end
