Gem::Specification.new do |spec|
  spec.name = 'shiftplanning'
  spec.version = '0.0.2'
  spec.author = 'FractalPenguin'
  spec.date = Time.now
  spec.add_dependency 'json'
  spec.email = 'kylerchrdsn@gmail.com'
  spec.files = Dir['lib/**/*.rb']
  spec.homepage = 'https://github.com/Kylerchrdsn/ShiftPlanning-ruby'
  spec.license = 'GPL-2'
  spec.summary = <<-EOF
    Aids in interacting with ShiftPlanning API. 
    Their site has SDKs for Javascript, PHP, C#, ASP.NET, and Python, but not Ruby @.@
  EOF
  spec.description = <<-EOF
    Copyright (C) 2013  Kyle Richardson

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
  EOF
end
