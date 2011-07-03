require 'ostruct'

module AudioLibrary; end

class AudioLibrary::PersistedTraverser
  include Enumerable

  def initialize path
    @path = path
  end

  def each
    File.open @path  do |file|
      while line = file.gets
        row = line.chomp.split '<->'
        tuples = AudioLibrary::Executor::FIELDS.map {|field| [field, row.shift]}.flatten
        o = OpenStruct.new Hash[*tuples]
        o.extend AudioLibrary::Tagged
        yield o
      end
    end if File.exist? @path
  end

  def clear
    File.open @path, 'w'
  end

  def append track
    File.open(@path, 'a') do |file|
      file.puts track.to_a.join('<->')
    end
  end
end