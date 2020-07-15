class PrestacionDePlanRepository
  def initialize
    @table_name = :prestaciones_de_planes
  end

  def save(prestacion_de_plan)
    id = insert(prestacion_de_plan)

    prestacion_de_plan.id = id

    prestacion_de_plan
  end

  def find(id)
    load_object(dataset.first!(pk_column => id))
  end

  def find_by_plan(plan)
    collection = load_collection dataset.where(plan_id: plan.id)
    prestaciones = []
    collection.each do |prestacion_de_plan|
      prestaciones << PrestacionRepository.new.find(prestacion_de_plan.prestacion_id)
    end

    prestaciones
  end

  def all
    load_collection(dataset)
  end

  private

  def insert(a_record)
    dataset.insert(changeset(a_record))
  end

  def dataset
    DB[@table_name]
  end

  def pk_column
    Sequel[@table_name][:id]
  end

  def load_object(a_record)
    plan = PlanRepository.new.find(a_record[:plan_id])
    prestacion = PrestacionRepository.new.find(a_record[:prestacion_id])
    prestacion_de_plan = PrestacionDePlan.new(plan, prestacion)
    prestacion_de_plan.id = a_record[:id]

    prestacion_de_plan
  end

  def load_collection(rows)
    rows.map { |a_record| load_object(a_record) }
  end

  def changeset(prestacion_de_plan)
    {
      plan_id: prestacion_de_plan.plan_id,
      prestacion_id: prestacion_de_plan.prestacion_id
    }
  end
end
