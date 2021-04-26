class SalariesService
  def self.salaries(destination)
    response = conn.get("/api/urban_areas/slug:#{destination}/salaries/")
    SalariesService.parser(response.body)
  end

  private

  def self.parser(body)
    JSON.parse(body, symbolize_names: true)
  end

  def self.conn
    Faraday.new("https://api.teleport.org")
  end
end
