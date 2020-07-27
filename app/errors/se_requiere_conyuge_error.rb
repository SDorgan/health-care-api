class SeRequiereConyugeError < StandardError
  def initialize(msg = 'este plan requiere conyuge')
    super
  end
end
