# frozen_string_literal: true
module Print
  class EmqxApi
    include CommonApi

    def clients(**options)
      r = get 'clients', origin: @app.base_url, **options
      r['data']
    end

    def publish(topic:, payload:, id:, **options)
      r = post(
        'publish',
        topic: topic,
        payload: payload,
        properties: {
          user_properties: {
            ids: id
          }
        },
        qos: 2,
        **options
      )
    end

    private
    def with_access_token(tries: 2, params: {}, headers: {}, payload: {})
      headers.merge! Authorization: "Basic #{Base64.strict_encode64([@app.key, @app.secret].join(':'))}"
      yield
    end

  end
end
