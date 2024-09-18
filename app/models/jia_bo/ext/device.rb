# frozen_string_literal: true
module JiaBo
  module Ext::Device
    extend ActiveSupport::Concern

    def print
      r = organ.device.print(
        data: to_tspl
      )
      r
    end

    def print_later
      PrintJob.perform_later(self)
    end

    def to_tspl
      ''
    end

  end
end
