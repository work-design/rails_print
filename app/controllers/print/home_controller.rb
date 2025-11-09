module Print
  class HomeController < BaseController
    skip_before_action :verify_authenticity_token, only: [:message]

    def message
      @mqtt_printer = MqttPrinter.find_or_initialize_by(dev_imei: params[:clientid])
      @mqtt_printer.save

      @mqtt_printer.register_success

      head :ok
    end

  end
end
