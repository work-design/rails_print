module Print
  class MqttUser < ApplicationRecord
    self.table_name = 'mqtt_user'
    include Model::MqttUser
  end
end
