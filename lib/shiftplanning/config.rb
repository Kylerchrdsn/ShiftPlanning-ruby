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

require 'uri'
require 'net/http'

class ShiftPlanning
  class Config
    # Setup class variables 
    @@uri = URI.parse("https://www.humanity.com/api/")
    @@http = Net::HTTP.new(@@uri.host, @@uri.port)
    @@http.use_ssl = true
    @@api_path = @@uri.path
    @@return_types = %w(json xml html)
    
    # Define getters and setters
    attr_accessor :api_key, :token
    attr_reader :output
    
    # Constructor
    #**********************************
    def initialize _api_key, options = {}
      self.api_key = _api_key
      self.output=(options[:output]||'json')
      self.token=(options[:token])
      @session = options[:session]
      self.token = @session[:sp_token] unless @session.nil?
      @@http.set_debug_output(options[:outfile]||$stdout) if options[:verbose]
    end
    
    # Setter for output type 
    #**********************************
    def output= _output
      _output = _output.to_s
        
      if @@return_types.include?(_output)
        @output = _output
      else
        raise "#{_output} is not a valid output type"
      end
    end
  end
end
