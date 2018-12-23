module Support
  def json
    @json ||= JSON.parse(response.body).with_indifferent_access
  end

  def auth_header
    {Authorization: "token api_key"}
  end
end
