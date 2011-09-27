require 'mkmf'

$CFLAGS << " -Iincludes "
$CFLAGS << "-DRUBY_#{RUBY_VERSION[0..2].sub(/\./,'_')} "
if RUBY_PLATFORM =~ /mingw/
  $CFLAGS << " -I../../../../../zlib/include "
  $CFLAGS << "-DSHOES_MINGW32 "
end
have_library("z")
create_makefile("binject")
