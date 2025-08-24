module Print
  module Model::Device
    extend ActiveSupport::Concern

    included do
      attribute :aim, :string
      attribute :online, :boolean, default: false

      enum :aim, {
        produce: 'produce',
        receipt: 'receipt'
      }, prefix: true

      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :printer, polymorphic: true
    end

    def sync_organ_from_printer
      if printer.organ_id
        self.organ_id = printer.organ_id
      end
    end

    def print(&block)
      printer.print(&block)
    end

    def print_later
      PrintJob.perform_later(self)
    end

  end
end
