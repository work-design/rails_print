module JiaBo
  class Admin::DeviceOrgansController < Admin::BaseController
    before_action :set_app, only: [:scan]
    before_action :set_device_organ, only: [:show, :edit, :update, :destroy, :actions, :test]
    before_action :set_new_device_organ, only: [:new, :create]

    def index
      @device_organs = current_organ.device_organs.includes(:device)
      @apps = JiaBo::App.all
    end

    def scan
      @device = @app.devices.find_or_initialize_by(device_id: params[:result])
      @device.device_organs.find_or_initialize_by(organ_id: current_organ.id)
      @device.save
    end

    def test
      @device_organ.device.test
    end

    private
    def set_device_organ
      @device_organ = DeviceOrgan.find params[:id]
    end

    def set_app
      @app = App.find params[:app_id]
    end

    def device_params
      params.fetch(:device_organ, {}).permit(
        :default
      )
    end

  end
end
