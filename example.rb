#! /usr/bin/env ruby

require 'shiftplanning.rb'
API_KEY = "9eea91f6fcaa9573b3949f4eb3b58b3d4624b2d0"

t = SP::Interface.new(API_KEY, :verbose => true)
r = SP::Request.new

test = t.submit(r.api.methods)
puts r.admin.settings.required_params(:delete)
