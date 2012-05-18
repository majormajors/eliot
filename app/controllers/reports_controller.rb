class ReportsController < ApplicationController
  respond_to :html, :json

  def index
    @reports = Report.all
  end

  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = Report.new    
  end

  def create
    @report = Report.new(params[:report])
    @report.save
    respond_with(@report)
  end

  def update
    @report = Report.find(params[:id])
    @report.update_attributes(params[:report])
    respond_with(@report)
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    respond_with(@report)
  end
end
