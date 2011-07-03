module AudioLibrary::Executor
  FIELDS = %w{path timestamp album track title artist time date albumartist puid mbartistid mbalbumid mbalbumartistid asin}

  attr_reader *FIELDS.map {|field| field.to_sym }

  def extract_file_attributes path
    @path = path.to_s
    @timestamp = path.timestamp
  end

  def clean_path path
    path.gsub("'", "\\'").gsub("!", "\\!").gsub("`", "\\`")
  end

  def to_a
    FIELDS.map { |field| send field }
  end
end