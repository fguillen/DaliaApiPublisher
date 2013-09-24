class Dalia::Api::Researcher::MockClient < Dalia::Api::Researcher::Client
  def initialize(opts = {})
    opts = {
      :account_id => "ACCOUNT_ID"
    }.merge(opts)

    super(opts)

    log.debug "Initialize MockClient"
  end

  def make_request_fetch_surveys(query)
    log.debug "make_request_fetch_surveys FAKE"

    JSON.parse_sym(File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/fetch_surveys.json"))
  end

  def make_request_fetch_survey(query)
    log.debug "make_request_fetch_survey FAKE"

    JSON.parse_sym(File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/fetch_survey.json"))
  end

  def make_request_send_survey(query)
    log.debug "make_request_send_survey FAKE"

    JSON.parse_sym(File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/send_survey.json"))
  end

  def make_request_update_survey(query)
    log.debug "make_request_update_survey FAKE"

    JSON.parse_sym(File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/update_survey.json"))
  end

  def make_request_fetch_completions(query)
    log.debug "make_request_fetch_completions FAKE"

    JSON.parse_sym(File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/fetch_completions.json"))
  end

  def make_request_fetch_completion(query)
    log.debug "make_request_fetch_completion FAKE"

    JSON.parse_sym(File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/fetch_completion.json"))
  end

  def make_request_create_query(query)
    log.debug "make_request_create_query FAKE"

    JSON.parse_sym(File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/create_query.json"))
  end
end
