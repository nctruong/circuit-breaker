class HomeController < ApplicationController
  def index
    speed = params[:speed]

    answers = Array(0..9).map do |i|
      sleep(1)
      puts "Request number #{i + 1}"
      speed = 'fast' if i > 3
      TargetClient.new(speed: speed).call
    end

    render json: answers
  end

  # http://localhost:3000/without-timeout
  def without_timeout
    speed = params[:speed]

    answers = Array(0..9).map do |i|
      sleep(1)
      puts "Request number #{i + 1}"
      HTTP.get("http://localhost:4000/?speed=#{speed}").status
    end

    render json: answers
  end

  # http://localhost:3000/with-timeout
  def with_timeout
    speed = params[:speed]

    answers = Array(0..9).map do |i|
      sleep(1)
      puts "Request number #{i + 1}"
      HTTP.timeout(0.1).get("http://localhost:4000/?speed=#{speed}").status
    end

    render json: answers
  end

  # http://localhost:3000/default-cb
  def default_circuit_breaker
    speed = params[:speed]

    answers = Array(0..9).map do |i|
      sleep(1)
      puts "Request number #{i + 1}"
      DefaultConfigClient.new(speed: speed).call
    end

    render json: answers
  end

  # http://localhost:3000/custom-cb
  def custom_circuit_breaker
    speed = params[:speed]

    answers = Array(0..9).map do |i|
      sleep(1)
      puts "Request number #{i + 1}"
      CustomConfigClient.new(speed: speed).call
    end

    render json: answers
  end

  # http://localhost:3000/recover-cb
  def recover_cb
    speed = params[:speed]

    answers = Array(0..9).map do |i|
      sleep(1)
      puts "Request number #{i + 1}"
      speed = 'fast' if i > 3 # after 5 loops change to fast mode
      CustomConfigClient.new(speed: speed).call
    end

    render json: answers
  end
end
