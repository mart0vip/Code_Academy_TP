#   Nombre
#   Tipo
#   Etapa
#   Descripcion
#   Area Responsable
#   Monto
#   Comuna
#   Barrio
#   Direction
#   Fecha Inicio
#   Fecha Fin
#   Porcentaje Avance
#   Link a imagen

class Obra
  attr_accessor  :id, :nombre, :etapa, :tipo, :area_responsable, :descripcion, :monto_contrato, :comuna, :barrio, :direccion, :fecha_inicio, :fecha_fin_planeada, :fecha_fin_real, :porcentaje_avance, :imagen

  def initialize(id, nombre, etapa, tipo, area_responsable, descripcion, monto_contrato, comuna, barrio, direccion, fecha_inicio, fecha_fin_planeada, fecha_fin_real, porcentaje_avance, imagen)
    @id = id
    @nombre = nombre
    @etapa = etapa
    @tipo = tipo
    @area_responsable = area_responsable
    @descripcion = descripcion
    @monto_contrato = monto_contrato
    @comuna = comuna
    @barrio = barrio
    @direccion = direccion
    @fecha_fin_planeada = fecha_fin_planeada
    @fecha_fin_real = fecha_fin_real
    @fecha_inicio = fecha_inicio
    @porcentaje_avance = porcentaje_avance
    @imagen = imagen

  end

  def ==(other_obra)
    @id == other_obra.id
  end
end