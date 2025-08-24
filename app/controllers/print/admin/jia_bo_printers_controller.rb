module Print
  class Admin::JiaBoPrintersController < Admin::BaseController
    before_action :set_jia_bo_apps
    before_action :set_jia_bo_printer, only: [:show, :edit, :update, :destroy, :actions, :test]
    before_action :set_new_jia_bo_printer, only: [:new, :create]
    before_action :set_jia_bo_app, only: [:scan]

    def index
      @jia_bo_printers = JiaBoPrinter.default_where(default_params)
    end

    def scan
      @jia_bo_printer = @jia_bo_app.jia_bo_printers.find_or_initialize_by(device_id: params[:result])
      @jia_bo_printer.organ = current_organ
      @jia_bo_printer.save
    end

    def test
      @jia_bo_printer.test_print
    end

    def edit
      @jia_bo_printer.devices.presence || @jia_bo_printer.devices.build
    end

    private
    def set_jia_bo_apps
      @jia_bo_apps = JiaBoApp.all
    end

    def set_jia_bo_app
      @jia_bo_app = JiaBoApp.find(params[:jia_bo_app_id])
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
        devices_attributes: [:aim]
      )
      p.merge! default_form_params
    end

  end
end
