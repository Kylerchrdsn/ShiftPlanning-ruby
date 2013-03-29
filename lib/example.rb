#! /usr/bin/env ruby

require 'rubygems'
require 'shiftplanning'
API_KEY = '9eea91f6fcaa9573b3949f4eb3b58b3d4624b2d0'#"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

interface = SP::Interface.new(API_KEY, :verbose => true, :outfile => '/home/krichardson/Desktop/output')
request   = SP::Request.new

request.staff.login.params = {:username => 'krichardson@customerdirect.com', :password => 'T0p@z098765'}#{:username => 'hmoon@nabootique.com', :password => 'J@zZ'}

interface.submit(request.staff.login)
puts interface.token
puts request.staff.login.supported_methods.inspect
puts request.staff.login.required_params('get').inspect

interface.submit(request.api.config, request.api.methods)
puts interface.requests.inspect; puts
puts interface.responses.inspect; puts
puts interface.last_response.inspect; puts

