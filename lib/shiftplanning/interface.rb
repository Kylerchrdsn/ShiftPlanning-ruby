require 'shiftplanning/config'
require 'shiftplanning/request'

class ShiftPlanning
  class Interface < ShiftPlanning::Config
    attr_reader(:last_request, :last_response, :requests, :responses, :last_response_raw)
    
    #**********************************
    def initialize api_key, options = {}
      super(api_key, options)
      @request = Net::HTTP::Post.new(@@api_path)
      @last_response = nil
      @last_request = nil
    end
    
    #**********************************
    def submit *args
      @requests = []; @responses = []
      msgs = []
      
      args.each{ |_request|
        _request.params[:module] = _request.module
        _request.params[:method] = _request.method
        req = {:key => api_key, :output => output, :request => _request.params}
        req[:token] = token unless token.nil?
        @requests << req
        req = JSON::generate(req)
        self.last_request = req#_request.to_json
        
        request.set_form_data({"data" => req})
        response = @@http.request(request)
        @last_response_raw = response
        
        if http_error?(response)
          raise HTTPError, response.code
        else
          (output == 'json' ? 
            (self.last_response = JSON.parse(response.body); @responses << JSON.parse(response.body)) : 
            (self.last_response = response.body; @responses << response.body)
          )
          
          @session[:sp_token] = last_response['token'] if(output == 'json' && @session != nil)  
          self.token = last_response['token'] if output == 'json'
          self.token = @session[:sp_token] unless @session.nil?
          msgs << response_msg(last_response['status']) if output == 'json'
        end
      }
      
      msgs
    end
    
    private
    def last_response=(response); @last_response = response end
    def last_request=(request); @last_request = request end
    def request; @request end
    def request=(request); @request = request end
    def http_error?(response); (response.code.to_i != 200) end
    
    #**********************************
    def response_msg code  
      case code.to_i
      when -3 : 'Flagged API Key - Pemanently Banned'
      when -2 : 'Flagged API Key - Too Many invalid access attempts - contact us'
      when -1 : 'Flagged API Key - Temporarily Disabled - contact us'
      when 1 : 'Success -'
      when 2 : 'Invalid API key - App must be granted a valid key by ShiftPlanning'
      when 3 : 'Invalid token key - Please re-authenticate'
      when 4 : 'Invalid Method - No Method with that name exists in our API'
      when 5 : 'Invalid Module - No Module with that name exists in our API'
      when 6 : 'Invalid Action - No Action with that name exists in our API'
      when 7 : 'Authentication Failed - You do not have permissions to access the service'
      when 8 : 'Missing parameters - Your request is missing a required parameter'
      when 9 : 'Invalid parameters - Your request has an invalid parameter type'
      when 10 : 'Extra parameters - Your request has an extra/unallowed parameter type'
      when 12 : 'Create Failed - Your CREATE request failed'
      when 13 : 'Update Failed - Your UPDATE request failed'
      when 14 : 'Delete Failed - Your DELETE request failed'
      when 20 : 'Incorrect Permissions - You don\'t have the proper permissions to access this'
      when 90 : 'Suspended API key - Access for your account has been suspended, please contact ShiftPlanning'
      when 91 : 'Throttle exceeded - You have exceeded the max allowed requests. Try again later.'
      when 98 : 'Bad API Paramaters - Invalid POST request. See Manual.'
      when 99 : 'Service Offline - This service is temporarily offline. Try again later.'
      else
        'Error code not found'
      end
    end
  end
end
