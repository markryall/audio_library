require 'audio_library/executor'

class AudioLibrary::FfmpegFile
  include AudioLibrary::Executor

  attr_reader :title, :album, :artist, :time, :date

  def initialize path
    clean_path path
    content = `ffmpeg -i \"#{path}\" 2>&1`
    state = :draining
    @meta = {}
    content.each_line do |line|
      l = line.chomp
      case l
        when "  Metadata:"
          state = :metadata
        else
          if state == :metadata
            begin
              m = / *: */.match l
              @meta[m.pre_match.strip] = m.post_match.strip if m
            rescue ArgumentError => e
            end
          end
      end
    end
    @title = @meta['TIT2'] || @meta['title']
    @album = @meta['TALB'] || @meta ['album']
    @artist = @meta['TPE1'] || @meta['TPE2'] || @meta['artist']
    @time = to_duration @meta['Duration']
    @date = @meta['TDRC'] || @meta['date']
  end

  def method_missing method
    @meta[method.to_s]
  end
private
  def to_duration s
    return 0 unless s
    first, *rest = s.split ','
    hours, minutes, seconds = first.split ':'
    seconds.to_i + (minutes.to_i * 60) + (hours.to_i * 60 * 60)
  end
end