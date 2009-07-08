gem 'rdoc', '~> 2.4'
require 'rdoc/generator/darkfish'

class RDoc::AnyMethod
  
  ##
  # Full method name for the CHM's index.
  # in the format:  
  #      method (Class)

  def chm_index_name  
    "#{name} (#{@parent.full_name})"
  end

end

class RDoc::Generator::CHM < RDoc::Generator::Darkfish

  VERSION = '2.4.0'

  RDoc::RDoc.add_generator( self )

  HHC_PATH = "c:/Program Files/HTML Help Workshop/hhc.exe"

  def initialize(options)
    super
    check_for_html_help_workshop
  end

  def check_for_html_help_workshop
    stat = File.stat(HHC_PATH)
  rescue
    $stderr <<
      "\n.chm output generation requires that Microsoft's Html Help\n" <<
      "Workshop is installed. RDoc looks for it in:\n\n    " <<
      HHC_PATH <<
      "\n\nYou can download a copy for free from:\n\n" <<
      "    http://msdn.microsoft.com/library/default.asp?" <<
      "url=/library/en-us/htmlhelp/html/hwMicrosoftHTMLHelpDownloads.asp\n\n"
  end

  ##
  # Generate the html as normal, then wrap it in a help project

  def generate( top_levels )
    super
    @project_name = "#{@outputdir.basename}.hhp"
    generate_help_project
  end

  ##
  # The project contains the project file, a table of contents and an index

  def generate_help_project
    debug_msg "Generating the help project files"
    generate_project_file
    generate_contents
    generate_chm_index
    compile_project
  end

  ##
  # The project file links together all the various
  # files that go to make up the help.
  def generate_project_file
    templatefile = @template_dir + 'hpp_file.rhtml'

    @values = { :title => @options.title, :opname => @outputdir.basename }
    
    @values[:html_files] = (@files+@classes).map{|f| f.path }
    @values[:html_files].unshift('index.html')

    outfile = @outputdir + @project_name
    debug_msg "  rendering #{outfile}"
    self.render_template( templatefile, binding(), outfile )
  end

  ##
  # generate the CHM contents (contents.hhc)
  def generate_contents
    templatefile = @template_dir + 'contents.rhtml'

    outfile = @outputdir + "contents.hhc"
    debug_msg "  rendering #{outfile}"
    self.render_template( templatefile, binding(), outfile )
  end

  ##
  # generate the CHM index (index.hhk)
  def generate_chm_index
    templatefile = @template_dir + 'chm_index.rhtml'
    
    outfile = @outputdir + "index.hhk"
    debug_msg "  rendering #{outfile}"
    self.render_template( templatefile, binding(), outfile )
  end

  ##
  # Invoke the windows help compiler to compiler the project
  def compile_project
    debug_msg "  compiling #{@project_name}"
    system(HHC_PATH, @project_name)
  end

end

