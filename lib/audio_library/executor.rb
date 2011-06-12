module AudioLibrary::Executor
  def clean_path path
    path.gsub("'", "\\'").gsub("!", "\\!").gsub("`", "\\`")
  end
end