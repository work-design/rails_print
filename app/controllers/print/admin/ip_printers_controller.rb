module Print
  class Admin::IpPrintersController < Admin::BaseController
    before_action :set_device, only: [:show, :edit, :update, :destroy, :actions]
    before_action :set_new_device, only: [:new, :create]

    def index
      @device_ips = IpPrinter.default_where(default_params).where(type: 'Print::DeviceIp')
    end

    def scan
      @ip_printer = @app.devices.find_or_initialize_by(device_id: params[:result])
      @ip_printer.device_organs.find_or_initialize_by(organ_id: current_organ.id)
      @ip_printer.save
    end

    def test
      @ip_printer.test_print
    end

    private
    def set_device
      @ip_printer = IpPrinter.find params[:id]
    end

    def set_new_device
      @ip_printer = IpPrinter.new(device_organ_params)
    end

    def device_organ_params
      p = params.fetch(:ip_printer, {}).permit(
        :ip
      )
      p.merge! default_form_params
    end

  end
end
