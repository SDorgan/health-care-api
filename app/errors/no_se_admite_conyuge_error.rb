class NoSeAdmiteConyugeError < StandardError
  def initialize(msg = 'este plan no admite conyuge')
    super
  end
end
