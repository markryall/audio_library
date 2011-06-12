class AudioLibrary::File
  def initialize path, root
    @path, @root = path, root
  end

  def timestamp
    @path.mtime.to_i
  end

  def to_s
    @path.to_s
  end
end