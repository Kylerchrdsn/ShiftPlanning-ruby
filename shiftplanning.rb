#!/usr/bin/env ruby

######################################
##     Shift Planning ruby SDK      ##
######################################
#                                    #
# Written By   : Fractal Penguin @.@ #
# Version      : 0.0.1               #
# Completed On : 2013-03-14          #
#                                    #
######################################

require 'rubygems'
require 'uri'
require 'net/http'
require 'json'
require 'shiftplanning/interface'
require 'shiftplanning/http_error'

class ShiftPlanning; VERSION = '0.0.1' end
# Aliasing ShiftPlanning as SP 
class SP < ShiftPlanning; end
