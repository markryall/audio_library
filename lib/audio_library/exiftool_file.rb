require 'audio_library/executor'

class AudioLibrary::ExiftoolFile
  include AudioLibrary::Executor

  attr_reader :title, :album, :artist, :time, :date

  def initialize path
    clean_path path
    content = `exiftool \"#{path}\"`
    @meta = {}
    content.each_line do |line|
      l = line.chomp
      begin
        m = / : /.match l
        @meta[m.pre_match.strip] = m.post_match.strip if m
      rescue ArgumentError => e
      end
    end
    @title = @meta['Title']
    @album = @meta['Album']
    @artist = @meta['Artist']
    @time = to_duration @meta['Duration']
    @date = @meta['Date/Time Original'] || @meta['Year']
  end

  def method_missing method
    @meta[method.to_s]
  end
private
  def to_duration s
    return 0 unless s
    first, *rest = s.split ' '
    minutes, seconds = first.split ':'
    seconds.to_i + (minutes.to_i * 60)
  end
end