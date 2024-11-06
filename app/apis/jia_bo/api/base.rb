# frozen_string_literal: true

module JiaBo::Api
  class Base
    include CommonApi

    def with_access_token(params: {}, headers: {}, tries: 2)
      params.merge!(
        reqTime: (Time.current.to_f * 1000).round.to_s,
        memberCode: @app.member_code
      )
      params.merge! securityCode: Digest::MD5.hexdigest([params[:memberCode], params[:reqTime], @app.api_key].join)
      yield
    end
  end
end
