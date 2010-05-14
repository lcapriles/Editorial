class Autor < ActiveRecord::Base
  validates_presence_of :fecha, :message => ' - Fecha Invalida'
  
  cattr_reader :per_page
  @@per_page = 7
  
  has_many :titulos

end
