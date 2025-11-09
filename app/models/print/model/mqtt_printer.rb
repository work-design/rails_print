module Print
  module Model::MqttPrinter
    extend ActiveSupport::Concern

    included do
      attribute :dev_imei, :string, index: true
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
      @api = $mqtt_user.api
    end

    def register_success
      api.publish "#{dev_imei}/unregistered", 'registerSuccess', false, 2
    end

    def register_401
      api.publish "#{dev_imei}/unregistered", 'registerFail@401', false, 2
    end

    def confirm_ready(payload)
      _, id = payload.split('#')
      api.publish "#{dev_imei}/confirm", "ready##{id}", false, 2
    end

    def confirm_exception(payload)
      _, id = payload.split('#')
      api.publish "#{dev_imei}/confirm", "exception##{id}", false, 2
    end

    def confirm_complete(payload)
      _, id = payload.split('#')
      api.publish "#{dev_imei}/confirm", "complete##{id}", false, 2
    end

  end
end
