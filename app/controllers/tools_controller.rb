class ToolsController < ApplicationController
  def search
    @employees = Employee.search params[:query]
    breakpoint
  end
end
