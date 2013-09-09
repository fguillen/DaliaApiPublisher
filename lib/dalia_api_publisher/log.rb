class Dalia::Api::Publisher::Log
  attr_reader :debug_mode

  def initialize(debug_mode = true)
    @debug_mode = debug_mode
  end

  def debug(message)
    return unless debug_mode

    result = "Dalia::Api::Publisher [#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}]: #{message}"

    if defined? ::Rails
      ::Rails.logger.info result
    else
      Kernel.puts result
    end
  end

  def log_options(options)
    debug "Options:"
    debug "-----------"
    options.each { |k,v| debug "#{k}: #{v}" }
  end

  def log_response(response)
    debug "Response:"
    debug "-----------"
    debug "response.request: #{response.request.last_uri}"
    debug "response.body: #{JSON.pretty_generate(JSON.parse(response.body))}"
    debug "response.code: #{response.code}"
    debug "response.message: #{response.message}"
  end
end