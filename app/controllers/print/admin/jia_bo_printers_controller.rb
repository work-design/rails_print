module Print
  class Admin::JiaBoPrintersController < Admin::BaseController
    before_action :set_jia_bo_apps
    before_action :set_jia_bo_printer, only: [:show, :edit, :update, :destroy, :actions, :test]
    before_action :set_new_jia_bo_printer, only: [:new, :create]

    def index
      @jia_bo_printers = JiaBoPrinter.default_where(default_params)
    end

    def scan
      @device = @app.devices.find_or_initialize_by(device_id: params[:result])
      @device.jia_bo_printers.find_or_initialize_by(organ_id: current_organ.id)
      @device.save
    end

    def test
      @device.test_print
    end

    def sync
      @app.sync_devices
    end

    private
    def set_jia_bo_apps
      @jia_bo_apps = JiaBoApp.all
    end

    def set_jia_bo_printer
      @jia_bo_printer = JiaBoPrinter.find params[:id]
    end

    def set_new_jia_bo_printer
      @jia_bo_printer = JiaBoPrinter.new(jia_bo_printer_params)
    end

    def jia_bo_printer_params
      p = params.fetch(:jia_bo_printer, {}).permit(
        :device_id,
        :dev_name,
        :aim
      )
      p.merge! default_form_params
    end

  end
end
