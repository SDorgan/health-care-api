require_relative '../../lib/date_manager'

class VisitaMedicaRepository < BaseRepository
  def initialize
    super(:visitas_medicas)
  end

  def save(visita_medica)
    id = insert(visita_medica)

    visita_medica.id = id

    visita_medica
  end

  def find_by_afiliado(criteria = {})
    id = criteria[:id]

    fecha = criteria[:fecha]

    if !fecha.nil?
      load_collection dataset.where(afiliado_id: id,
                                    created_on: (fecha[:inicio]..fecha[:fin]))
    else
      load_collection dataset.where(afiliado_id: id)
    end
  end

  private

  def load_object(a_record)
    prestacion = PrestacionRepository.new.find(a_record[:prestacion_id])
    centro = CentroRepository.new.find(a_record[:centro_id])
    fecha_visita = a_record[:created_on]

    visita_medica = VisitaMedica.new(a_record[:afiliado_id], prestacion, centro, fecha_visita)
    visita_medica.id = a_record[:id]

    visita_medica
  end

  def changeset(visita_medica)
    {
      afiliado_id: visita_medica.afiliado_id,
      prestacion_id: visita_medica.prestacion.id,
      centro_id: visita_medica.centro.id,
      created_on: visita_medica.fecha_visita
    }
  end
end
