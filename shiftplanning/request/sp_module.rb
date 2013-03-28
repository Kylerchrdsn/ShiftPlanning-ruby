class SPModule
  # Setup getters and setters 
  attr_reader :supported_methods, :module
  attr_accessor :params, :method
  
  # Constructor 
  #**********************************
  def initialize _module = '', _method = '', _params = {}, supported_methods = %w(GET), required_params = {:GET => []}
    @supported_methods = supported_methods
    @required_params = required_params
    @params = _params
    @module = _module
    @method = _method 
  end
  
  #**********************************
  def required_params method
    case method.class.to_s
    when 'Symbol' : method = method.to_s.upcase.to_sym
    when 'String' : method = method.upcase.to_sym
    else
      raise %q('method' should be a String or a Symbol)
    end
    
    case method
    when :GET : @required_params[:GET]||'Unsupported method'
    when :CREATE : @required_params[:CREATE]||'Unsupported method' 
    when :UPDATE : @required_params[:UPDATE]||'Unsupported method'
    when :DELETE : @required_params[:DELETE]||'Unsupported method'
    end
  end
end
