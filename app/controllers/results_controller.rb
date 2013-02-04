# encoding: utf-8

class ResultsController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @result = Result.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create
    @result = Result.new params[:result]

    respond_to do |format|
      if @result.save
        format.js
      end
    end
  end

  def update
    @result = Result.find(params[:id])

    respond_to do |format|
      if @result.update_attributes(params[:result])
        format.html { redirect_to @result, :notice => 'Изменения сохранены' }
        format.js
      else
        format.html { render :action => 'edit' }
      end

    end
  end

  def destroy
    @result = Result.find(params[:id])
    @result.destroy

    respond_to do |format|
      format.js
    end
  end
end