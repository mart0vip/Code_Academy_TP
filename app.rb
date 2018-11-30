# frozen_string_literal: true

require 'sinatra'
require 'byebug'
require './models/obra_exception.rb'
require './models/persistence_manager.rb'
require './models/obra.rb'

get '/' do
  index
end

post '/obras' do
  @title = 'Registration form - Preview'
#  def initialize(id, nombre, etapa, tipo, area_responsable, descripcion, monto_contrato, comuna, barrio, direccion, fecha_inicio, fecha_fin_planeada, fecha_fin_real, porcentaje_avance, imagen)

  @errors = []
  @obra = Obra.new params['id'], params['nombre'], params['etapa'], params['tipo'], 
  params['area_responsable'], 
  params['descripcion'], 
  params['monto_contrato'], 
  params['comuna'], 
  params['barrio'], 
  params['direccion'], 
  params['fecha_inicio'], 
  params['fecha_fin_planeada'], 
  params['fecha_fin_real'], 
  params['porcentaje_avance'], 
  params['imagen']




  persistence_manager = PersistenceManager.new
  begin
    persistence_manager.add_obra @obra
  rescue => exception
    @errors << exception.message
  end

  if @errors.empty?
    erb :obra_details
  else
    index
  end
end

get '/obras' do
  obras
end

delete '/obras/:id' do
  @errors = []
  persistence_manager = PersistenceManager.new

  begin
    persistence_manager.delete_obra params[:id]
  rescue => exception
    @errors << exception.message
  end

  if @errors.empty?
    @success_delete = true
    obras
  else
    obras
  end
end

get '/obras/:id' do
  @errors = []
  persistence_manager = PersistenceManager.new
  @tipo_options = %w[Ejecucion Licitacion Proyecto Terminada]

  begin
    @current_obra = persistence_manager.get_obra(params[:id])
  rescue => exception
    @errors << exception.message
  end

  erb :edit
end

put '/obra/:id' do
  @errors = []
  persistence_manager = PersistenceManager.new

  begin
    @obra = persistence_manager.get_obra(params[:id])

    @obra.id= params[:id]
    @obra.nombre = params[:nombre]
    @obra.etapa = params[:etapa]
    @obra.tipo = params[:tipo]
    @obra.area_responsable = params[:area_responsable]
    @obra.descripcion = params [:descripcion]
    @obra.monto_contrato = params[:monto_contrato]
    @obra.comuna = params[:comuna]
    @obra.barrio = params[:barrio]
    @obra.direccion = params[:direccion]
    @obra.fecha_inicio = params[:fecha_inicio]
    @obra.fecha_fin_planeada = params[:fecha_fin_planeada]
    @obra.fecha_fin_real = params[:fecha_fin_real]
    @obra.porcentaje_avance = params[:porcentaje_avance]
    @obra.imagen = params[:imagen]


    persistence_manager.edit_obra(@obra)
  rescue ObraException => exception
    @errors << exception.message
  end

  erb :obra_details
end


get '/about' do
  @title = 'About'
  erb :about
end

def index
  @title = 'Registration form'
  @tipo_options = %w[Ejecucion Licitacion Proyecto Terminada]
  erb :index
end

private

def obras
  persistence_manager = PersistenceManager.new
  @obras_list = persistence_manager.obras_list
  erb :obras
end

