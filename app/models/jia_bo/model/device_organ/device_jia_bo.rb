module JiaBo
  module Model::DeviceOrgan::DeviceJiaBo

    def print(esc)
      device.print(
        data: esc.render_raw,
        mode: 3,
        cmd_type: 'ESC'
      )
    end

  end
end