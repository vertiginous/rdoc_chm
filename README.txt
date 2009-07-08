= \RDoc_CHM

* {RDoc Project Page}[http://rubyforge.org/projects/rdoc/]
* {RDoc Documentation}[http://rdoc.rubyforge.org/rdoc_chm]
* {RDoc Bug Tracker}[http://rubyforge.org/tracker/?atid=2472&group_id=627&func=browse]

== DESCRIPTION:

An unmaintained Microsoft Compiled HTML Help generator for RDoc.

== FEATURES/PROBLEMS:

* Unmaintained, only known to work with RDoc 2.3.0

== SYNOPSIS:

  gem 'rdoc'
  require 'rdoc/rdoc'
  
  RDoc::RDoc.new.document "-f chm", # ... see RDoc

== REQUIREMENTS:

* RDoc 2.3 (probably works with newer RDoc 2.x versions)
* Requires installation of Microsoft's HTML Help Workshop

== INSTALL:

* sudo gem install rdoc_chm

== LICENSE:

RDoc is Copyright (c) 2001-2003 Dave Thomas, The Pragmatic Programmers.  It is
free software, and may be redistributed under the terms specified in the
README file of the Ruby distribution.

