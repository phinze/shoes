require 'mkmf'
require 'fileutils'

$CFLAGS << " -I../../c "

%w[../../c/notation.c ../../c/bloopsaphone.c ../../c/bloopsaphone.h].each do |fn|
  abort "!! ERROR !!\n** #{fn} not found; type 'make ruby' in the top directory\n\n" \
    unless File.exists? fn
  FileUtils.cp(fn, ".")
end

find_library("portaudio", nil, "../../../../../portaudio/lib")
create_makefile("bloops")
