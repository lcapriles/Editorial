# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def params_check(*args) #TODO: Agregar a scaffold...
  #Usage
  #if params[:object] && !params[:object].empty --> 
  #   if params_check(:object)
  #if params[:object] && params[:object] == value --> 
  #   if params_check(:object, value)
  #if params[:object][:attribute] && !params[:object][:attribute].empty --> 
  #   if params_check([:object, :attribute])
  #if params[:object][:attribute] && params[:object][:attribute] == value -->
  #   if params_check([:object, :attribute], value)

    if args.length == 1
      if args[0].class == Array
        if params[args[0][0]][args[0][1]] && !params[args[0][0]][args[0][1]].empty?
          true
        end
      else        
        if params[args[0]] && !params[args[0]].empty?
          true
        end
      end
    elsif args.length == 2
      if args[0].class == Array
        if params[args[0][0]][args[0][1]] && params[args[0][0]][args[0][1]] == args[1]
          true
        end
      else
        if params[args[0]] && params[args[0]] == args[1]
          true
        end
      end  
    end
  end
  
  def format_date_string_DMY_to_YMD(*args) #TODO: Agregar a scaffold...
    if args.length == 1
      re1 = /(\d{1,2})[.-\/](\d{1,2})[.-\/](\d{2,4})/ #dd/mm/yyy
      date_d = args[0][re1,1]
      date_m = args[0][re1,2]
      date_y = args[0][re1,3]
      if date_y.blank? 
        re1 = /(\d{1,2})[.-\/](\d{2,4})/ #mm/yyyy
        date_m = args[0][re1,1]
        date_y = args[0][re1,2] 
        if date_y.blank?
          re1 = /(\d{2,4})/ #yyyy
          date_y = args[0][re1,1]
          if date_y.blank?
            return '*'
          else
            return ( date_y + "*" ) #yyyy*
          end
        else
          return ( date_y + "/" + date_m + "/*" ) #yyyy/mm* TODO: No parece funcionar en MySQL...
        end
      else
        return ( date_y + "/" + date_m + "/" + date_d ) #yyy/mm/dd
      end
    end
  end
  
  def build_qbe(*args)
    params.each do |key, value| 
      if @qbe_key.attribute_names().include?(key) #Con esto, solo vemos los argumentos propios a la clase...
        if not value.blank?
          if key.include?('fecha') #Si estamos evaluando una fecha... queremos convertirla en formato :DB
            value1 = format_date_string_DMY_to_YMD(value)
          else
            value1 = value
          end
          value2 = value1
          if value1.include?('*') #Si se especifica * en un campo del QBE, queremos reemplazarlo por un % para el "like"... 
            oper = ' like ' #TODO: oper se debe poder especificar en el QBE...
            value1 = value1.sub(/[*]/, '%') 
          else
            oper = ' = '
          end
          if @qbe_select.nil?
            @qbe_select =  key + oper +  "'" + value1 + "'" 
            @qbe_key[key] = value2 #Es mejor usar "value2" para asignar adecuadamente el formato de la fecha...
          else
            @qbe_select = @qbe_select + " and " + key + oper  + "'" + value1 + "'" 
            @qbe_key[key] = value2 #Es mejor usar "value2" para asignar adecuadamente el formato de la fecha...
          end
        end
      end
    end
  end
  
end
