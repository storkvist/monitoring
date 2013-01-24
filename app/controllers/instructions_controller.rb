# encoding: utf-8

class InstructionsController < ApplicationController
  before_filter :authenticate_user!

  def index

  end

  def new

  end

  def create
    @instruction = Instruction.new params[:instruction]

    respond_to do |format|
      if @instruction.save
        format.js
      end
    end
  end
end