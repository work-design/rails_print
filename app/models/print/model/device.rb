module Print
  module Model::Device
    extend ActiveSupport::Concern

    included do
      attribute :type, :string
      attribute :identifier, :string
      attribute :aim, :string
      attribute :extra, :json
      attribute :cmd_type, :string
      attribute :online, :boolean, default: false

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
