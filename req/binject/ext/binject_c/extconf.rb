require 'mkmf'

$CFLAGS << " -Iincludes "
$CFLAGS << "-DRUBY_#{RUBY_VERSION[0..2].sub(/\./,'_')} "
if RUBY_PLATFORM =~ /mingw/
  $CFLAGS << " -I../../../../../zlib/include "
  $CFLAGS << "-DSHOES_MINGW32 "
end
find_library("z", nil, "../../../../../zlib/lib")
create_makefile("binject")
