# frozen_string_literal: true
module Print
  module Ext::Device
    extend ActiveSupport::Concern

    def print
      r = organ.device.print(
        data: to_tspl
      )
    end

    def print_later
      PrintJob.perform_later(self)
    end

    def to_tspl
      ''
    end

  end
end
