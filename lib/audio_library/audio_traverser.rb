class AudioLibrary::AudioTraverser
  attr_reader :current
  EXTS = %w{m4a mp3 ogg wma}.map {|e| '.'+e }

  def initialize path
    @traverser = AudioLibrary::Traverser.new path
  end

  def next
    loop do
      break unless @traverser.next
      break if is_audio?
    end
    @traverser.current
  end

  def current
    @traverser.current
  end

  def timestamp
    @traverser.timestamp
  end
private
  def is_audio?
    current.file? and EXTS.include? current.extname.downcase
  end
end