module Print
  class Admin::JiaBoPrintersController < Panel::JiaBoPrintersController

    def index
      @jia_bo_printers = JiaBoPrinter.default_where(default_params)
    end

  end
end
