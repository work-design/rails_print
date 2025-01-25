module RailsPrint
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir[
      "#{config.root}/app/models/device"
    ]

    config.eager_load_paths += Dir[
      "#{config.root}/app/models/device"
    ]

  end
end
