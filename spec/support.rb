module Support
  def json
    @json ||= parse_json(response.body)
  end

  def parse_json(json_str)
    result = JSON.parse(json_str)
    result.is_a?(Hash) ? result.with_indifferent_access : result
  end

  def auth_header
    {Authorization: "token api_key"}
  end
end
