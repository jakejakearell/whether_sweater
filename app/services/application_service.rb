class ApplicationService

  def self.parser(body)
    JSON.parse(body, symbolize_names: true)
  end
end
