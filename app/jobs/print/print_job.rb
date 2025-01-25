module Print
  class PrintJob < ApplicationJob

    def perform(item)
      item.print
    end

  end
end
