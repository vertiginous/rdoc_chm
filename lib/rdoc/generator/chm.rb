require 'rdoc/rdoc'
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

  VERSION = '3.1.0'

  DESCRIPTION = 'Microsoft Compiled HTML Help (chm) generator'

  RDoc::RDoc.add_generator( self )

  HHC_PATH = "#{ENV['PROGRAMFILES']}/HTML Help Workshop/hhc.exe"

  def initialize(options)
    check_for_html_help_workshop
    super
  end

  def check_for_html_help_workshop
    unless File.exists?(HHC_PATH)
      warn <<
        "\n.chm output generation requires that Microsoft's Html Help\n" <<
        "Workshop is installed. RDoc looks for it in:\n\n    " <<
        HHC_PATH <<
        "\n\nYou can download a copy for free from:\n\n" <<
        "    http://msdn.microsoft.com/library/default.asp?" <<
        "url=/library/en-us/htmlhelp/html/hwMicrosoftHTMLHelpDownloads.asp\n\n"
    end
  end


  ##
  # Generate the html as normal, then wrap it in a help project

  def generate top_levels
    super
    @project_name = "#{@outputdir.basename}.hhp"
    generate_help_project
  end

  ##
  # The project contains the project file, a table of contents and an index

  def generate_help_project
    # Set which files should actually be generated
    @generated_files = @files.select { |f| f.text? }

    debug_msg "Generating the help project files"
    generate_file_index
    generate_class_index
    generate_project_file
    generate_contents
    generate_chm_index
    compile_project
  end

  def generate_file_index
    template_file = @template_dir + 'fileindex.rhtml'

    out_file = @outputdir + "fileindex.html"
    # suppress 1.9.3 warning
    rel_prefix = rel_prefix = @outputdir.relative_path_from(out_file.dirname)

    debug_msg "  rendering #{out_file}"
    render_template template_file, out_file do |io| binding end
  end

  def generate_class_index
    template_file = @template_dir + 'classindex.rhtml'

    out_file = @outputdir + "classindex.html"
    debug_msg "  rendering #{out_file}"
    # suppress 1.9.3 warning
    rel_prefix = rel_prefix = @outputdir.relative_path_from(out_file.dirname)

    render_template template_file, out_file do |io| binding end
  end

  ##
  # The project file links together all the various
  # files that go to make up the help.
  def generate_project_file
    template_file = @template_dir + 'hhp_file.hhp.rhtml'

    @values = { :title => @options.title, :opname => @outputdir.basename }
    
    static_files = ['index.html', 'classindex.html', 'fileindex.html']
    @values[:html_files] = static_files + (@generated_files+@classes).map{|f| f.path}.uniq
    
    out_file = @outputdir + @project_name
    debug_msg "  rendering #{out_file}"
    render_template template_file, out_file do |io| binding end
  end

  ##
  # generate the CHM contents (contents.hhc)
  def generate_contents
    template_file = @template_dir + 'contents.hhc.rhtml'

    out_file = @outputdir + "contents.hhc"
    debug_msg "  rendering #{out_file}"
    render_template template_file, out_file do |io| binding end
  end

  ##
  # generate the CHM index (index.hhk)
  def generate_chm_index
    template_file = @template_dir + 'chm_index.hhk.rhtml'
    
    out_file = @outputdir + "index.hhk"
    debug_msg "  rendering #{out_file}"
    render_template template_file, out_file do |io| binding end
  end

  ##
  # Invoke the windows help compiler to compiler the project
  def compile_project
    debug_msg "  compiling #{@project_name}"
    system(HHC_PATH, @project_name)
  end

  ##
  # This is an override to make sure that the new Darkfish template
  # doesn't try to parse the CHM files as html partials
  def assemble_template body_file
    if body_file.basename.to_s =~ /\.hh(k|c|p)/
      body = body_file.read
      return body if body
    else
      super
    end
  end
end

