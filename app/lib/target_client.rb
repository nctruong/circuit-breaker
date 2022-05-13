require 'circuitbox/circuit_breaker'

Circuitbox::CircuitBreaker.class_eval do
  def run(run_options = {})
    begin
      run!(run_options, &Proc.new { yield }) if block_given?
    rescue Circuitbox::Error
      nil
    end
  end
end

class TargetClient
  def initialize(speed:)
    @speed = speed
    @circuit = ::Circuitbox.circuit(
      :target_server,
      exceptions: [HTTP::TimeoutError], # exceptions circuitbox tracks for counting failures (required)
      time_window: 5, # calculate error rate in 5 seconds
      volume_threshold: 2, # number of requests within `time_window` seconds before it calculates error rates (checked on failures)
      sleep_window: 2 # stay open in 2 seconds before closing for next time
    )
  end

  attr_reader :speed, :circuit

  def call
    circuit.run(circuitbox_exceptions: false) do
      HTTP.timeout(0.1).get("http://target-server:4000/?speed=#{speed}").status
    end
  end
end
