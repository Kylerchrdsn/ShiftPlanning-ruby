#! /usr/bin/env ruby

require 'shiftplanning.rb'
API_KEY = "9eea91f6fcaa9573b3949f4eb3b58b3d4624b2d0"

t = SP::Interface.new(API_KEY, :token => 'bb92f866a8efceda4f73c5e98e4a4e1f21a6207e', :verbose => true)
r = SP::Request.new

t.submit(r.staff.employees); to_del = []

puts t.token
puts;puts

t.last_response['data'].each{ |row|
  if row['status_name'] == 'Not Activated'
    to_del << row['id'].to_i
  end
}

r.staff.employee.method = 'DELETE'
to_del.each{ |e|
  r.staff.employee.params = {:id => e}
  t.submit(r.staff.employee)
}