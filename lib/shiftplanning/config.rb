require 'uri'
require 'net/http'

class ShiftPlanning
  class Config
    # Setup class variables 
    @@uri = URI.parse("http://www.shiftplanning.com/api/")
    @@http = Net::HTTP.new(@@uri.host, @@uri.port)
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
