module AudioLibrary
  def self.parse path
    AudioLibrary::FfmpegFile.new path.to_s
  end
end

require 'audio_library/id3_file'
require 'audio_library/ffmpeg_file'
require 'audio_library/exiftool_file'
require 'audio_library/audio_traverser'
require 'audio_library/traverser'