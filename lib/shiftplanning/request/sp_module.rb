=begin
  
  Copyright (C) 2013 Kyle Richardson

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; either version 2
  of the License, or (at your option) any later version.
  
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
   
=end

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
    when 'Symbol'
      method = method.to_s.upcase.to_sym
    when 'String'
      method = method.upcase.to_sym
    else
      raise %q('method' should be a String or a Symbol)
    end
    
    case method
    when :GET
      @required_params[:GET]||'Unsupported method'
    when :CREATE
      @required_params[:CREATE]||'Unsupported method' 
    when :UPDATE
      @required_params[:UPDATE]||'Unsupported method'
    when :DELETE
      @required_params[:DELETE]||'Unsupported method'
    end
  end
end
