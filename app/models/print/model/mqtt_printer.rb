module Print
  module Model::MqttPrinter
    extend ActiveSupport::Concern

    included do
      attribute :dev_imei, :string
      attribute :dev_type, :string
      attribute :dev_vendor, :string
      attribute :dev_network, :string
      attribute :dev_spec, :string
      attribute :dev_desc, :string
      attribute :online, :boolean

      #belongs_to :mqtt_app
    end

    def api
      return @api if defined? @api
      @api = $mqtt_api
    end

    def register_success
      api.publish "#{dev_imei}/unregistered", 'registerSuccess', false, 2
    end

    def register_401
      api.publish "#{dev_imei}/unregistered", 'registerFail@401', false, 2
    end

  end
end
