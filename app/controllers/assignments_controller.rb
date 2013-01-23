# encoding: utf-8

class AssignmentsController < ApplicationController
  before_filter :authenticate_user!

  def index

  end

  def new

  end

  def create
    @assignment = Assignment.new params[:assignment]

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment,
                                  :notice => 'Задача создана.' }
        format.js
        format.json { render :json => @assignment, :status => :created,
                             :location => @assignment }
      else
        format.html { render :action => 'new' }
        format.json { render :json => @assignment.errors,
                             :status => :unprocessable_entity }
      end
    end
  end
end