class ServersController < ApplicationController
  respond_to :html, :except => [ :version ]
  respond_to :json, :except => [ :new, :edit, :version ]
  respond_to :text, :only => [ :version ]

  def index
    @servers = Server.all
  end

  def show
    @server = Server.find(params[:id])
  end

  def new
    @server = Server.new
  end

  def create
    @server = Server.new(params[:server])
    @server.save
    respond_with(@server)
  end

  def edit
    @server = Server.find(params[:id])
  end

  def update
    @server = Server.find(params[:id])
    @server.update_attributes(params[:server])
    respond_with(@server)
  end

  def destroy
    @server = Server.find(params[:id])
    @server.destroy
    respond_with(@server)
  end

  def version
    @server = Server.where(id: params[:id].to_i).first
    respond_to do |format|
      format.text { render :text => @server.version }
    end
  end
end
