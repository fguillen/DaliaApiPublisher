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
  end

  def fetch_surveys(opts)
    check_required_options(opts, :account_id)
    response = make_request_fetch_surveys(opts)

    response
  end

  def fetch_survey(opts)
    check_required_options(opts, :account_id, :survey_id)
    response = make_request_fetch_survey(opts)

    response
  end

  def send_survey(opts)
    check_required_options(opts, :account_id, :data)
    response = make_request_send_survey(opts)

    response
  end

  def fetch_completions(opts)
    check_required_options(opts, :account_id, :survey_id)
    response = make_request_fetch_completions(opts)

    response
  end

  def fetch_completion(opts)
    check_required_options(opts, :account_id, :survey_id, :completion_id)
    response = make_request_fetch_completion(opts)

    response
  end

private

  def make_request_fetch_surveys(query)
    make_request("/api/publishers/#{query.delete(:account_id)}/surveys", query)
  end

  def make_request_fetch_survey(query)
    make_request("/api/publishers/#{query.delete(:account_id)}/surveys/#{query.delete(:survey_id)}", query)
  end

  def make_request_send_survey(query)
    make_request("/api/publishers/#{query.delete(:account_id)}/surveys/", query, :method => :post)
  end

  def make_request_fetch_completions(query)
    make_request("/api/publishers/#{query.delete(:account_id)}/surveys/#{query.delete(:survey_id)}/completions", query)
  end

  def make_request_fetch_completion(query)
    make_request("/api/publishers/#{query.delete(:account_id)}/surveys/#{query.delete(:survey_id)}/completions/#{query.delete(:completion_id)}", query)
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