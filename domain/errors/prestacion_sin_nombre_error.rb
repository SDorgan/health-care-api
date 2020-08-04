class PrestacionSinNombreError < StandardError
  def initialize(msg = 'se debe especificar un nombre')
    super(msg)
  end
end
