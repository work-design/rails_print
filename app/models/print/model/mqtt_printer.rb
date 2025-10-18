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
      superuser = MqttUser.where(is_superuser: true).take
      @api = superuser.api
    end

    def register_success
      api.publish "#{dev_imei}/unregistered", 'registerSuccess'
    end

    def register_401
      api.publish "#{dev_imei}/unregistered", 'registerFail@401'
    end

  end
end
