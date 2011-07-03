require 'audio_library/tagged'

module AudioLibrary::Executor
  include AudioLibrary::Tagged

  def extract_file_attributes path
    @path = path.to_s
    @timestamp = path.timestamp
  end

  def clean_path path
    path.gsub("'", "\\'").gsub("!", "\\!").gsub("`", "\\`")
  end
end