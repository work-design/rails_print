module JiaBo
  class Panel::DeviceOrgansController < Panel::BaseController
    before_action :set_app, :set_device
    before_action :set_device_organ, only: [:show, :edit, :update, :destroy, :actions]
    before_action :set_new_device_organ, only: [:new, :create]

    def index
      @device_organs = @device.device_organs.page(params[:page])
    end

    private
    def set_app
      @app = App.find params[:app_id]
    end

    def set_device
      @device = @app.devices.find params[:device_id]
    end

    def set_device_organ
      @device_organ = @device.device_organs.find params[:id]
    end

    def set_new_device_organ
      @device_organ = @device.device_organs.build device_organ_params
    end

    def device_organ_params
      params.fetch(:device_organ, {}).permit(
        :device_id,
        :organ_id,
        :default
      )
    end

  end
end
