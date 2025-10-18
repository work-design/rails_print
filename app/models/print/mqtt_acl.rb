module Print
  class MqttAcl < ApplicationRecord
    self.table_name = 'mqtt_acl'
    include Model::MqttAcl
  end
end
