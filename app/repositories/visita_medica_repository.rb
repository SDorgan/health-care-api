require_relative '../../lib/date_manager'
class VisitaMedicaRepository < BaseRepository
  def initialize
    super(:visitas_medicas)
  end

  def save(visita_medica)
    visita_medica.created_on = DateManager.date

    id = insert(visita_medica)

    visita_medica.id = id

    visita_medica
  end

  def find_by_afiliado(id)
    load_collection dataset.where(afiliado_id: id)
  end

  private

  def load_object(a_record)
    prestacion = PrestacionRepository.new.find(a_record[:prestacion_id])
    centro = CentroRepository.new.find(a_record[:centro_id])

    visita_medica = VisitaMedica.new(a_record[:afiliado_id], prestacion, centro)
    visita_medica.id = a_record[:id]
    visita_medica.created_on = a_record[:created_on]

    visita_medica
  end

  def changeset(visita_medica)
    {
      afiliado_id: visita_medica.afiliado_id,
      prestacion_id: visita_medica.prestacion.id,
      centro_id: visita_medica.centro.id,
      created_on: visita_medica.created_on
    }
  end
end
