class Dalia::Api::Publisher::MockClient < Dalia::Api::Publisher::Client
  def initialize(opts = {})
    opts = {
      :account_id => "ACCOUNT_ID"
    }.merge(opts)

    super(opts)

    log.debug "Initialize MockClient"
  end

  def make_request_fetch_surveys(query)
    log.debug "make_request_fetch_surveys FAKE"

    JSON.parse(
      File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/fetch_surveys.json"),
      :symbolize_names => true
    )
  end

  def make_request_fetch_survey(query)
    log.debug "make_request_fetch_survey FAKE"

    JSON.parse(
      File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/fetch_survey.json"),
      :symbolize_names => true
    )
  end

  def make_request_send_survey(query)
    log.debug "make_request_send_survey FAKE"

    JSON.parse(
      File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/send_survey.json"),
      :symbolize_names => true
    )
  end

  def make_request_fetch_completions(query)
    log.debug "make_request_fetch_completions FAKE"

    JSON.parse(
      File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/fetch_completions.json"),
      :symbolize_names => true
    )
  end

  def make_request_fetch_completion(query)
    log.debug "make_request_fetch_completion FAKE"

    JSON.parse(
      File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/fetch_completion.json"),
      :symbolize_names => true
    )
  end
end
