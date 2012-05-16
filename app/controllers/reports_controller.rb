class ReportsController < ApplicationController
  helper_method :current_server
  respond_to :html, :json

  def show
    @report = current_server.reports.find(params[:id])
  end

  def create
    @report = current_server.reports.build(params[:report])
    @report.save
    respond_with(current_server, @report)
  end

  def update
    @report = current_server.reports.find(params[:id])
    @report.update_attributes(params[:report])
    respond_with(current_server, @report)
  end

  def destroy
    @report = current_server.reports.find(params[:id])
    @report.destroy
    respond_with(@report, :location => server_path(current_server))
  end

private

  def current_server
    @server ||= Server.find(params[:server_id])
  end
end
