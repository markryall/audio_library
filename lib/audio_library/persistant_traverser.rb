require 'ostruct'

class AudioLibrary::PersistantTraverser
  def initialize audio_path, store_path
    @traverser = AudioLibrary::AudioTraverser.new audio_path
    @persisted = AudioLibrary::PersistedTraverser.new store_path
  end

  def each
    existing = existing_entries
    @traverser.each do |path|
      track = existing[path.to_s] || AudioLibrary.parse(path)
      @persisted append track
      yield track
    end
  end
private
  def existing_entries
    entries = {}
    @persisted.each do |entry|
      entries[entry.path] = entry
    end
    @persisted.clear
    entries
  end
end