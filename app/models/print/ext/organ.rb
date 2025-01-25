module Print
  module Ext::Organ
    extend ActiveSupport::Concern

    included do
      has_one :device_receipt, -> { where(aim: 'receipt') }, class_name: 'Print::DeviceOrgan'
      has_one :device_produce, -> { where(aim: 'produce') }, class_name: 'Print::DeviceOrgan'

      has_many :device_organs, class_name: 'Print::DeviceOrgan', dependent: :delete_all
      has_many :devices, class_name: 'Print::Device', through: :device_organs
    end

  end
end
