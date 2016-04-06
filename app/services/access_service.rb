class AccessService
  attr_reader :connection, :webservice_id
  def initialize
    @connection = Faraday.new("http://achecker.ca/checkacc.php")
    @webservice_id = "053a6e7b5b79e3bb12bdb581a40e4bc90b235736"
  end

  def get(path)
    connection.get do |req|
      req.params['uri'] = "https://api.github.com#{path}"
      req.params['id'] = @webservice_id
      req.params['guide'] = "STANCA,WCAG2-AA"
      req.params['offset'] = "10"
    end
  end

private
  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
