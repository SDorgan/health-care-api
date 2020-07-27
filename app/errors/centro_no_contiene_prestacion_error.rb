class CentroNoContienePrestacionError < StandardError
  def initialize(msg = 'La prestación pedida no se ofrece en el centro')
    super
  end
end
