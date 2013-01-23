# encoding: utf-8

class DepartmentsController < ApplicationController
  before_filter :authenticate_user!

  # GET /departments
  # GET /departments.json
  def index
    @departments = Department.all
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    @department = Department.find(params[:id])
  end

  # GET /departments/new
  # GET /departments/new.json
  def new
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit
    @department = Department.find(params[:id])
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(params[:department])

    @department.save ?
      redirect_to @department, :notice => 'Подразделение создано' :
      render :action => 'new'
  end

  # PUT /departments/1
  # PUT /departments/1.json
  def update
    @department = Department.find(params[:id])

    @department.update_attributes(params[:department]) ?
      redirect_to @department, :notice => 'Изменения сохранены.' :
      render :action => 'edit'
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department = Department.find(params[:id])
    @department.destroy

    redirect_to departments_url
  end
end
