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
    response("fetch_surveys.json")
  end

  def make_request_fetch_survey(query)
    log.debug "make_request_fetch_survey FAKE"
    response("fetch_survey.json")
  end

  def make_request_send_survey(query)
    log.debug "make_request_send_survey FAKE"
    response("send_survey.json")
  end

  def make_request_update_survey(query)
    log.debug "make_request_update_survey FAKE"
    response("update_survey.json")
  end

  def make_request_fetch_completions(query)
    log.debug "make_request_fetch_completions FAKE"
    response("fetch_completions.json")
  end

  def make_request_fetch_completion(query)
    log.debug "make_request_fetch_completion FAKE"
    response("fetch_completion.json")
  end

  def make_request_fetch_survey_price(query)
    log.debug "make_request_fetch_survey_price FAKE"
    response("fetch_survey_price.json")
  end

  def make_request_create_query(query)
    log.debug "make_request_create_query FAKE"
    response("create_query.json")
  end

private

  def response(file_response)
    response =
      RecursiveOpenStruct.new(
        :body => File.read("#{File.dirname(__FILE__)}/../../etc/fake_responses/#{file_response}"),
        :code => 200,
        :message => "<message>",
        :request => {
          :last_url => "<last_url>"
        }
      )

    log.log_response response

    JSON.parse_sym(response.body)
  end
end
