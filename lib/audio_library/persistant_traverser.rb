require 'audio_library'
require 'audio_library/persisted_traverser'
require 'audio_library/audio_traverser'
require 'audio_library/parser'

class AudioLibrary::PersistantTraverser
  def initialize audio_path, store_path
    @audio_path, @store_path = audio_path, store_path
  end

  def each
    with_existing_entries do |existing_entries, persisted|
      AudioLibrary::AudioTraverser.new(@audio_path).each do |path|
        existing = existing_entries[path.to_s]
        existing = nil if existing and existing.timestamp != path.timestamp
        #existing = nil if existing and existing.no_tag_fields?
        track = existing || AudioLibrary::Parser.parse(path)
        persisted.append track
        yield track
      end
    end
  end
private
  def with_existing_entries
    persisted = AudioLibrary::PersistedTraverser.new @store_path
    entries = {}
    persisted.each do |entry|
      entries[entry.path] = entry
    end
    persisted.clear
    yield entries, persisted
  end
end