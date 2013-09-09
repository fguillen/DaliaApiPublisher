class Dalia::Api::Publisher::Client
  attr_accessor :options
  attr_reader :log
  attr_reader :response

  def initialize(opts = {})
    @options = {
      :debug_mode => false,
      :api_host => "http://daliaresearch.com"
    }.merge!(opts)

    @log = Dalia::Api::Publisher::Log.new(options[:debug_mode])

    log.log_options(options)

    check_required_options(options, :application_key, :secret_key)
  end

  def fetch_surveys(opts)
    check_required_options(opts, :device_id, :device_id_kind)

    query = make_query(opts)
    response = make_request_fetch_surveys(query)

    response
  end

  def fetch_survey(opts)
    check_required_options(opts, :survey_id, :device_id, :device_id_kind)

    query = make_query(opts)
    response = make_request_fetch_survey(query)

    response
  end

  def send_completion(opts)
    check_required_options(opts, :survey_id, :completion, :device_id, :device_id_kind)

    query = make_query(opts)
    response = make_request_send_completion(query)

    response
  end

  def send_prequalification_success(opts)
    check_required_options(opts, :survey_id, :device_id, :device_id_kind)

    query = make_query(opts)
    response = make_request_send_prequalification_success(query)

    response
  end

  def send_prequalification_fail(opts)
    check_required_options(opts, :survey_id, :device_id, :device_id_kind)

    query = make_query(opts)
    response = make_request_send_prequalification_fail(query)

    response
  end

private

  def check_required_options(options_hash, required_options)
    errors =
      required_options.map do |required_option|
        "#{required_option} required"       if !options_hash[:required_option]
      end.join(", ")

    raise Dalia::Api::Publisher::Exception, errors.join(", ") if !errors.empty?
  end

  def make_query(opts)
    query =
      opts.merge(
        :access_key => options[:access_key],
        :application_key => options[:application_key]
      )

    query
  end

  def make_request_fetch_surveys(query)
    make_request("/api/surveys", query)
  end

  def make_request_fetch_survey(query)
    make_request("/api/surveys/#{query[:survey_id]}", query)
  end

  def make_request_send_completion(query)
    make_request("/api/surveys/#{query[:survey_id]}/completions", query, :method => :post)
  end

  def make_request_send_prequalification_success(query)
    make_request("/api/surveys/#{query[:survey_id]}/prequalification_success", query, :method => :post)
  end

  def make_request_send_prequalification_fail(query)
    make_request("/api/surveys/#{query[:survey_id]}/prequalification_fail", query, :method => :post)
  end

  def make_request(api_path, query, opts = {})
    opts[:method] ||= :get

    api_url = "#{options[:api_host]}#{api_path}"

    log.debug "api_url: #{api_url}"
    log.debug "api_query: #{query.inspect}"

    response =
      if opts[:method] == :get
        HTTParty.get(api_url, :query => query)
      else
        HTTParty.post(api_url, :body => query)
      end

    log.log_response response

    raise Dalia::Api::Publisher::Exception, response.message if response.code != 200

    JSON.parse(response.body, :symbolize_names => true)
  end

  def check_required_options(options_hash, *required_options)
    errors =
      required_options.map do |required_option|
        "#{required_option} required" if !options_hash[required_option]
      end.compact.join(", ")

    raise Dalia::Api::Publisher::Exception, errors if !errors.empty?
  end

end