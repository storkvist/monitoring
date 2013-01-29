class ToolsController < ApplicationController
  def search
    @employees = Employee.search params[:query]
    breakpoint
  end

  def similar
    @similar_tasks = []
    keys = []
    ComplexQueries.similar_tasks.each do |pair|
      key = [pair['a1'], pair['a2']].sort.join('_')
      unless keys.include?(key)
        @similar_tasks.push pair
        keys.push key
      end
    end
  end
end
