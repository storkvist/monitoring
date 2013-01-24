# encoding: utf-8

class ResultsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @result = Result.new params[:result]

    respond_to do |format|
      if @result.save
        format.js
      end
    end
  end
end