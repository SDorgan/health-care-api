class PrestacionNotExistsError < StandardError
  def initialize(msg = 'La prestación pedida no existe')
    super
  end
end
