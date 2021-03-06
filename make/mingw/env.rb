require File.expand_path('make/make')
extend Make

EXT_RUBY = "../ruby19_mingw"

# use the platform Ruby claims
require 'rbconfig'

CC = ENV['CC'] ? ENV['CC'] : "gcc"
file_list = ["shoes/*.c"] + %w{shoes/native/windows.c shoes/http/winhttp.c shoes/http/windownload.c}
  
SRC = FileList[*file_list]
OBJ = SRC.map do |x|
  x.gsub(/\.\w+$/, '.o')
end

ADD_DLL = ["shoes/appwin32.o"]

# should be referenced in make/mingw/tasks.rb #copy_deps_to_dist to copy the files listed
# in 'dlls'; why those names are in a file and not listed here I cannot tell you; most of this
# logic makes little sense in how it was structured.
SANDBOX_DLL_PATHS = [
  "../glib/bin", "../cairo/bin", "../pango/bin", "../libjpeg/mingw/bin", "../libungif/bin",
  "../portaudio/bin", "../zlib/bin", "../sqlite3", "../ruby19_mingw/bin"
  ]

# Linux build environment
#CAIRO_CFLAGS = '-I/mingw/include/glib-2.0 -I/mingw/lib/glib-2.0/include -I/mingw/include/cairo'
CAIRO_CFLAGS = '-I../glib/include/glib-2.0 -I../glib/lib/glib-2.0/include -I../cairo/include/cairo'
CAIRO_LIB = '-L../glib/lib -L../cairo/lib -lcairo'
#PANGO_CFLAGS = '-I/mingw/include/pango-1.0'
PANGO_CFLAGS = '-I../pango/include/pango-1.0'
PANGO_LIB = '-L../pango/lib -lpangocairo-1.0 -lpango-1.0 -lpangoft2-1.0 -lpangowin32-1.0'
#LINUX_CFLAGS = %[-Wall -I#{ENV['SHOES_DEPS_PATH'] || "/usr"}/include #{CAIRO_CFLAGS} #{PANGO_CFLAGS} -I#{Config::CONFIG['archdir']}]
LINUX_CFLAGS = %[ -I#{ENV['SHOES_DEPS_PATH'] || "/usr"}/include #{CAIRO_CFLAGS} #{PANGO_CFLAGS} -I#{Config::CONFIG['archdir']} -I../libjpeg/mingw/include]
if Config::CONFIG['rubyhdrdir']
  LINUX_CFLAGS << " -I#{Config::CONFIG['rubyhdrdir']} -I#{Config::CONFIG['rubyhdrdir']}/#{RUBY_PLATFORM}"
end
LINUX_LIB_NAMES = %W[#{RUBY_SO} cairo pangocairo-1.0 ungif]
  
FLAGS.each do |flag|
  LINUX_CFLAGS << " -D#{flag}" if ENV[flag]
end
if ENV['DEBUG']
  LINUX_CFLAGS << " -g -O0 "
else
  LINUX_CFLAGS << " -O "
end
LINUX_CFLAGS << " -DRUBY_1_9"

DLEXT = 'dll'
#LINUX_CFLAGS << ' -I. -I/mingw/include'
#LINUX_CFLAGS << ' -I/mingw/include/ruby-1.9.1/ruby'
#LINUX_CFLAGS << ' -I../ruby19_mingw/include/ruby-1.9.1/ruby'
LINUX_CFLAGS << " -DXMD_H -DHAVE_BOOLEAN -DSHOES_WIN32 -D_WIN32_IE=0x0500 -D_WIN32_WINNT=0x0500 -DWINVER=0x0500 -DCOBJMACROS"
LINUX_LDFLAGS = " -DBUILD_DLL -L../libjpeg/mingw/lib -L../libungif/lib -L../winhttp/lib "
LINUX_LDFLAGS << " -lungif -ljpeg -lglib-2.0 -lgobject-2.0 -lgio-2.0 -lgmodule-2.0 -lgthread-2.0 -fPIC -shared"
LINUX_LDFLAGS << ' -lshell32 -lkernel32 -luser32 -lgdi32 -lcomdlg32 -lcomctl32 -lole32 -loleaut32 -ladvapi32 -loleacc -lwinhttp'

cp APP['icons']['win32'], "shoes/appwin32.ico"
  
LINUX_LIBS = LINUX_LIB_NAMES.map { |x| "-l#{x}" }.join(' ')

LINUX_LIBS << " -L#{Config::CONFIG['libdir']} #{CAIRO_LIB} #{PANGO_LIB}"
