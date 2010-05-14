class Titulo < ActiveRecord::Base
  validates_presence_of :fecha, :message => ' - Fecha Invalida'
  
  cattr_reader :per_page
  @@per_page = 7
  
  belongs_to :autor
end
