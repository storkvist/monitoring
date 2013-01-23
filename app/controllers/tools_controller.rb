class ToolsController < ApplicationController
  def search
    @employees = Employee.search params[:query]
  end
end
