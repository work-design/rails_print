module JiaBo
  module Model::Device
    extend ActiveSupport::Concern

    included do
      attribute :type, :string
      attribute :aim, :string
      attribute :extra, :json
      attribute :cmd_type, :string

      enum :aim, {
        produce: 'produce',
        receipt: 'receipt'
      }, prefix: true

      enum :cmd_type, {
        esc: 'esc'
      }, prefix: true

      belongs_to :organ, class_name: 'Org::Organ', optional: true
    end

  end
end
