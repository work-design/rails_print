module Print
  module Model::MqttUser
    extend ActiveSupport::Concern

    included do
      attribute :username, :string
      attribute :password_digest, :string

      has_secure_password validations: false
    end

  end
end
