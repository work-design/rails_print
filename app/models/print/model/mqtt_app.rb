module Print
  module Model::MqttApp
    extend ActiveSupport::Concern

    included do
      attribute :key, :string
      attribute :secret, :string
      attribute :base_url, :string
    end

  end
end
