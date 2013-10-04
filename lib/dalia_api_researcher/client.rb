class Dalia::Api::Researcher::Client
  attr_accessor :options
  attr_reader :log
  attr_reader :response

  def initialize(opts = {})
    @options = {
      :debug_mode => false,
      :api_host => "http://daliaresearch.com"
    }.merge!(opts)

    @log = Dalia::Api::Researcher::Log.new(options[:debug_mode])

    log.log_options(options)
  end

  def fetch_surveys(opts)
    check_required_options(opts, :account_id)
    make_request_fetch_surveys(opts)
  end

  def fetch_survey(opts)
    check_required_options(opts, :account_id, :survey_id)
    make_request_fetch_survey(opts)
  end

  def send_survey(opts)
    check_required_options(opts, :account_id, :data)
    make_request_send_survey(opts)
  end

  def update_survey(opts)
    check_required_options(opts, :account_id, :survey_id, :data)
    make_request_update_survey(opts)
  end

  def fetch_completions(opts)
    check_required_options(opts, :account_id, :survey_id)
    make_request_fetch_completions(opts)
  end

  def fetch_completion(opts)
    check_required_options(opts, :account_id, :survey_id, :completion_id)
    make_request_fetch_completion(opts)
  end

  def fetch_survey_price(opts)
    check_required_options(opts, :account_id)
    make_request_fetch_survey_price(opts)
  end

  def create_query(opts)
    check_required_options(opts, :account_id, :survey_id, :question_id)
    make_request_create_query(opts)
  end

private

  def make_request_fetch_surveys(query)
    make_request("/api/researcher/researcher_users/#{query.delete(:account_id)}/surveys", query)
  end

  def make_request_fetch_survey(query)
    make_request("/api/researcher/researcher_users/#{query.delete(:account_id)}/surveys/#{query.delete(:survey_id)}", query)
  end

  def make_request_send_survey(query)
    make_request("/api/researcher/researcher_users/#{query.delete(:account_id)}/surveys/", query, :method => :post)
  end

  def make_request_update_survey(query)
    make_request("/api/researcher/researcher_users/#{query.delete(:account_id)}/surveys/#{query.delete(:survey_id)}", query, :method => :put)
  end

  def make_request_fetch_completions(query)
    make_request("/api/researcher/researcher_users/#{query.delete(:account_id)}/surveys/#{query.delete(:survey_id)}/completions", query)
  end

  def make_request_fetch_completion(query)
    make_request("/api/researcher/researcher_users/#{query.delete(:account_id)}/surveys/#{query.delete(:survey_id)}/completions/#{query.delete(:completion_id)}", query)
  end

  def make_request_fetch_survey_price(query)
    make_request("/api/researcher/researcher_users/#{query.delete(:account_id)}/surveys/price", query, :method => :post)
  end

  def make_request_create_query(query)
    make_request("/api/researcher/researcher_users/#{query.delete(:account_id)}/surveys/#{query.delete(:survey_id)}/query", query)
  end

  def make_request(api_path, query, opts = {})
    opts[:method] ||= :get

    api_url = "#{options[:api_host]}#{api_path}"

    log.debug "api_url: #{api_url}"
    log.debug "api_query: #{query.inspect}"

    response =
      case opts[:method]
      when :get then HTTParty.get(api_url, :query => query)
      when :post then HTTParty.post(api_url, :body => query)
      when :put then HTTParty.put(api_url, :body => query)
      end

    log.log_response response

    raise Dalia::Api::Researcher::Exception, response.message if response.code != 200

    JSON.parse_sym(response.body)
  end

  def check_required_options(options_hash, *required_options)
    errors =
      required_options.map do |required_option|
        "#{required_option} required" if !options_hash[required_option]
      end.compact.join(", ")

    raise Dalia::Api::Researcher::Exception, errors if !errors.empty?
  end

end