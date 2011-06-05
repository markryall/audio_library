module AudioLibrary::Executor
  def clean_path path
    path.gsub! "'", "\\'"
    path.gsub! "!", "\\!"
    path.gsub! "`", "\\`"
  end
end