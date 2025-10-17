require 'bcrypt'
module Print
  module Model::MqttUser
    extend ActiveSupport::Concern

    included do
      attribute :username, :string
      attribute :password_hash, :string
    end

    def set_pass!(password, cost: 10)
      self.password_hash = BCrypt::Password.create(password, cost: cost)
      self.save
    end

  end
end
