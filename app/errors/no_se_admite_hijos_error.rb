class NoSeAdmiteHijosError < StandardError
  def initialize(msg = 'este plan no admite hijos')
    super
  end
end
