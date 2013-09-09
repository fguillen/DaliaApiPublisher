class Dalia::Api::Publisher::MockClient < Dalia::Api::Publisher::Client
  def initialize(opts = {})
    opts = {
      :application_key => "APPLICATION-KEY",
      :secret_key => "SECRET-KEY",
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

  def make_request_send_completion(query)
    log.debug "make_request_send_completion FAKE"

    JSON.parse(
      File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/send_completion.json"),
      :symbolize_names => true
    )
  end

  def make_request_send_prequalification_success(query)
    log.debug "make_request_send_prequalification_fail FAKE"

    JSON.parse(
      File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/send_prequalification_success.json"),
      :symbolize_names => true
    )
  end

  def make_request_send_prequalification_fail(query)
    log.debug "make_request_send_prequalification_fail FAKE"

    JSON.parse(
      File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/send_prequalification_fail.json"),
      :symbolize_names => true
    )
  end
end
