module JiaBo
  module Ext::Organ
    extend ActiveSupport::Concern

    included do
      has_one :device_receipt, -> { where(aim: 'receipt') }, class_name: 'JiaBo::DeviceOrgan'
      has_one :device_produce, -> { where(aim: 'produce') }, class_name: 'JiaBo::DeviceOrgan'

      has_many :device_organs, class_name: 'JiaBo::DeviceOrgan', dependent: :delete_all
      has_many :devices, class_name: 'JiaBo::Device', through: :device_organs
    end

  end
end
