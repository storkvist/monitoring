# encoding: utf-8

class EmployeesController < ApplicationController
  before_filter :authenticate_user!

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    @employee = Employee.find(params[:id])
  end

  # GET /employees/new
  # GET /employees/new.json
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
    @employee = Employee.find(params[:id])
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(params[:employee])

    if @employee.save
      redirect_to @employee, :notice => 'Сотрудник добавлен.'
    else
      render :action => 'new'
    end
  end

  # PUT /employees/1
  # PUT /employees/1.json
  def update
    @employee = Employee.find(params[:id])

    if @employee.update_attributes(params[:employee])
      redirect_to @employee, :notice => 'Изменения сохранены.'
    else
      render :action => 'edit'
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    redirect_to employees_url
  end
end
