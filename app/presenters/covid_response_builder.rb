class CovidResponseBuilder
  def self.create_from(respuesta)
    {
      'sospechoso': respuesta
    }.to_json
  end
end
