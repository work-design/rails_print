module Print
  class Admin::DevicesController < Admin::BaseController
    before_action :set_app, only: [:scan]
    before_action :set_device, only: [:show, :edit, :update, :destroy, :actions, :test]
    before_action :set_new_device, only: [:new, :create]

    def index
      @device_jia_bos = current_organ.device_organs.includes(:device).where(type: 'Print::DeviceJiaBo')
      @device_ips = current_organ.device_organs.where(type: 'Print::DeviceIp')
    end

    def scan
      @device = @app.devices.find_or_initialize_by(device_id: params[:result])
      @device.device_organs.find_or_initialize_by(organ_id: current_organ.id)
      @device.save
    end

    def test
      @device.test_print
    end

    def sync
      @app.sync_devices
    end

    private
    def set_app
      @app = App.find params[:app_id]
    end

    def set_device
      @device = Device.find params[:id]
    end

    def set_new_device
      @device = Device.new(device_organ_params)
    end

    def device_organ_params
      p = params.fetch(:device_organ, {}).permit(
        :default,
        :ip,
        :aim
      )
      p.merge! default_form_params
    end

  end
end
