class PlanService
  def initialize(repo_planes)
    @repo_planes = repo_planes
  end

  def buscar(params = {})
    nombre_plan = params[:nombre]

    if nombre_plan.nil?
      planes = @repo_planes.all
      PlanResponseBuilder.create_from_all(planes)
    else
      plan = @repo_planes.find_by_name(nombre_plan)
      PlanResponseBuilder.create_from(plan)
    end
  rescue PlanNoEncontrado
    raise PlanInexistenteError
  end
end
