class ToolsController < ApplicationController
  def search
    @employees = Employee.search params[:query]
    breakpoint
  end

  def similar
    @similar_tasks = ComplexQueries.similar_tasks
  end
end
