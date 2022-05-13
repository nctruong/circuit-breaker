class CustomConfigClient
  def initialize(speed:)
    @speed = speed
    @circuit = ::Circuitbox.circuit(
      :node_client_custom_config,
      exceptions: [HTTP::TimeoutError],
      time_window: 5,
      volume_threshold: 2,
      sleep_window: 2
    )
  end

  def call
    circuit.run do
      HTTP.timeout(0.1).get("http://localhost:4000/?speed=#{speed}").status
    end
  end

  private

  attr_reader :speed, :circuit
end
