class AutorsController < ApplicationController

  before_filter :localize_date, :only => [:update, :create]
  def localize_date #TODO: Será posible que convierta cualquier campo fecha de la clase??
      params[:autor][:fecha].gsub!(/[.\/]/,'-') #Si la fecha es con "-", ROR entiende formato europeo dd-mm-yyy!!!
  end
  
  # GET /autors
  # GET /autors.xml
  def index
    
    @qbe_key = Autor.new() #Con esto, solo veremos los argumentos propios a la clase...
    #En base al qbe_key construido en la vista, se construye el qbe_select para el select...
    build_qbe(params)  #TODO: Mejorar uso parámetors... que no sean "cableados"... 
    
    if  not @qbe_select.nil?
      @autors = Autor.paginate :page => params[:page],  :order => 'id ASC', :conditions =>  @qbe_select 
    else
      @autors = Autor.paginate :page => params[:page],  :order => 'id ASC'
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @autors }
    end
  end
  
  # GET /autors/1
  # GET /autors/1.xml  
  def show
    @autor = Autor.find(params[:id])
    @titulos = Titulo.paginate :page => params[:page], :order => 'id ASC', 
                               :conditions => " autor_id = " + params[:id] 
    @titulo = Titulo.new 
    session[:id] = params[:id]
    @titulo.autor_id = session[:id]
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @autor }
    end
  end
  
  # GET /autors/new
  # GET /autors/new.xml
  def new
    @autor = Autor.new
#    @autors = Autor.find(:all) // TODO: Ver si esto hace falta
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @autor }
    end
  end
  
  # GET /autors/1/edit
  def edit
    @autor = Autor.find(params[:id])
  end
  
  # POST /autors
  # POST /autors.xml
  def create
    @autor = Autor.new(params[:autor])
    
    respond_to do |format|
      if @autor.save
        flash[:notice] = ''
        format.html { redirect_to(autors_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @autor.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /autors/1
  # PUT /autors/1.xml
  def update
    @autor = Autor.find(params[:id])
    
    respond_to do |format|
      if @autor.update_attributes(params[:autor])
        flash[:notice] = ''
        format.html { redirect_to(autors_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @autor.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /autors/1
  # DELETE /autors/1.xml
  def destroy
    @autor = Autor.find(params[:id])
    @autor.destroy
    
    respond_to do |format|
      format.html { redirect_to(autors_url) }
      format.xml  { head :ok }
    end
  end
  
  def auto_complete_for_autor_nombre
    @autors = Autor.find(:all, :conditions => "nombre like " + "'" + params[:autor][:nombre] + "%'" )
  end

  def index_select #Presentamos la ventana Index modal...
    @qbe_key = Autor.new() 
    @autors = Autor.paginate :page => params[:page],  :order => 'id ASC'
    session[:pagina] = 1
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @autors }
    end
  end
 
  def index_select1  #Actualizamos el grid de la ventana Index modal...
    @qbe_key = Autor.new()
    build_qbe(params)  #TODO: Mejorar uso parámetors... que no sean "cableados"...   
    session[:pagina] = session[:pagina] + params[:page].to_i    #TODO: CRITICO - Manejo Nro.Pg negativos
    if  not @qbe_select.nil? 
      @autors = Autor.paginate :page => params[:page],  :order => 'id ASC', :conditions =>  @qbe_select 
    else
      @autors = Autor.paginate :page => session[:pagina],  :order => 'id ASC'
    end
    render "index_select1.html", :layout => false
  end 
  
end
