class DefaultConfigClient
  def initialize(speed:)
    @speed = speed
    @circuit = ::Circuitbox.circuit(:node_client, exceptions: [HTTP::TimeoutError])
  end

  def call
    circuit.run do
      HTTP.timeout(0.1).get("http://localhost:4000/?speed=#{speed}").status
    end
  end

  private

  attr_reader :speed, :circuit
end
