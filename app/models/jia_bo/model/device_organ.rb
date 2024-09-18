module JiaBo
  module Model::DeviceOrgan
    extend ActiveSupport::Concern

    included do
      attribute :default, :boolean, default: true

      belongs_to :device
      belongs_to :organ, class_name: 'Org::Organ'

      after_update :set_default, if: -> { default? && saved_change_to_default? }
    end

    def set_default
      self.class.where.not(id: self.id).where(organ_id: self.organ_id).update_all(default: false)
    end

  end
end
