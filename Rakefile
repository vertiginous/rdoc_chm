# -*- ruby -*-

require 'rubygems'
require 'hoe'

$:.unshift 'lib'
require 'rdoc/rdoc'
require 'rdoc/generator/chm'

Hoe.new 'rdoc_chm', RDoc::Generator::CHM::VERSION do |rdoc_chm|
  rdoc_chm.rubyforge_name = 'rdoc'

  rdoc_chm.developer 'Gordon Thiesfeld', 'gthiesfeld@gmail.com'
  rdoc_chm.developer 'Eric Hodel', 'drbrain@segment7.net'
  rdoc_chm.developer 'Dave Thomas', ''
  rdoc_chm.developer 'Tony Strauss', 'tony.strauss@designingpatterns.com'

  rdoc_chm.extra_deps << ['rdoc', '~> 2.4']

  rdoc_chm.testlib = :minitest

  rdoc_chm.extra_dev_deps << ['minitest', '~> 1.3']
  rdoc_chm.spec_extras['required_rubygems_version'] = '>= 1.3'
  rdoc_chm.spec_extras['homepage'] = 'http://rdoc.rubyforge.org/rdoc_chm'
end

# vim: syntax=Ruby
