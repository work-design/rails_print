module Print
  class Admin::IpPrintersController < Admin::BaseController
    before_action :set_ip_printer, only: [:show, :edit, :update, :destroy, :actions]
    before_action :set_new_ip_printer, only: [:new, :create]

    def index
      @ip_printers = IpPrinter.default_where(default_params).page(params[:page])
    end

    def test
      @ip_printer.test_print
    end

    private
    def set_ip_printer
      @ip_printer = IpPrinter.find params[:id]
    end

    def set_new_ip_printer
      @ip_printer = IpPrinter.new(ip_printer_params)
    end

    def ip_printer_params
      p = params.fetch(:ip_printer, {}).permit(
        :ip,
        :port
      )
      p.merge! default_form_params
    end

  end
end
