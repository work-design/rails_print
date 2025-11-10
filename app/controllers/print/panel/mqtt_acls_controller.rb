module Print
  class Panel::MqttAclsController < Panel::BaseController
    before_action :set_mqtt_user

    def index
      @mqtt_acls = @mqtt_user.mqtt_acls.page(params[:page])
    end

    private
    def set_mqtt_user
      @mqtt_user = MqttUser.find params[:mqtt_user_id]
    end

  end
end
