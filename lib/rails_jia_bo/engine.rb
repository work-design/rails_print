module RailsJiaBo
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir[
      "#{config.root}/app/models/device_organ"
    ]

    config.eager_load_paths += Dir[
      "#{config.root}/app/models/device_organ"
    ]

  end
end
