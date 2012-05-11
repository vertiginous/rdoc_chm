# -*- ruby -*-

require 'rubygems'
require 'hoe'

$:.unshift 'lib'

Hoe.plugin :git

Hoe.spec 'rdoc_chm' do |rdoc_chm|
  rdoc_chm.rubyforge_name = 'rdoc'

  rdoc_chm.developer 'Gordon Thiesfeld', 'gthiesfeld@gmail.com'
  rdoc_chm.developer 'Eric Hodel', 'drbrain@segment7.net'
  rdoc_chm.developer 'Dave Thomas', ''
  rdoc_chm.developer 'Tony Strauss', 'tony.strauss@designingpatterns.com'

  rdoc_chm.readme_file = 'README.rdoc'

  rdoc_chm.extra_deps << ['rdoc', '~> 3.12']

  rdoc_chm.testlib = :minitest

  rdoc_chm.extra_dev_deps << ['minitest', '~> 1.3']
  rdoc_chm.spec_extras['required_rubygems_version'] = '>= 1.3'
  rdoc_chm.spec_extras['homepage'] = 'http://rdoc.rubyforge.org/rdoc_chm'
end

desc "Build chm files"
task :chm => :clean do
  sh %q{ rdoc --fmt chm --op rdoc_chm --title="rdoc_chm 2.4.0" --main=README.rdoc . }
end

task :clobber_chm do
  rm_rf "rdoc_chm"
end

desc "rebuild chm files"
task :rechm => [:clobber_chm, :chm] 

# vim: syntax=Ruby
