require 'audio_library/tagged'

class String
  def escape char
    split(char).join("\\#{char}")
  end
end

module AudioLibrary::Executor
  include AudioLibrary::Tagged

  def extract_file_attributes path
    @path = path.to_s
    @timestamp = path.timestamp
  end

  def clean_path path
    path.escape(" ").escape("'").escape("!").escape("`").escape("(").escape(")").escape("&")
  end

  def execute command
    debug command
    `#{command} 2>&1`
  end

  def debug message
    puts message if ENV['DEBUG']
  end
end