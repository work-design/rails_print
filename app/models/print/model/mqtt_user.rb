module Print
  module Model::MqttUser
    extend ActiveSupport::Concern

    included do
      attribute :username, :string
      attribute :salt, :string
      attribute :password_hash, :string
    end

  end
end
