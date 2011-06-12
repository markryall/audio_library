require 'audio_library/ffmpeg_file'

module AudioLibrary
  module Parser
    def self.parse path
      AudioLibrary::FfmpegFile.new path
    end
  end
end