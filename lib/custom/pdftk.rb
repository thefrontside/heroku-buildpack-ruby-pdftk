require 'fileutils'
class Pdftk < BaseCustom
  def vendor_path
    File.expand_path(File.dirname(__FILE__), '..', '..', 'vendor')
  end
  def path
    "#{build_path}/vendor/#{name}"
  end
  def name
    "pdftk"
  end
  def pdftk_path
    "#{vendor_path}/pdftk.tar.gz"
  end
  def used?
    File.exist?("#{build_path}/bin/pdftk") && File.exist?("#{build_path}/bin/lib/libgcj.so.12")
  end
  def compile
    write_stdout "compiling #{name}"
    FileUtils.mkdir_p path
    Dir.chdir path do
      %x{ tar -xz -C #{path} -f #{pdftk_path} }
    end
    write_stdout "complete compiling #{name}"
  end
  def cleanup!
  end
  def prepare
    File.delete("#{build_path}/bin/lib/libgcj.so.12") if File.exist?("#{build_path}/bin/libgcj.so.12")
    File.delete("#{build_path}/bin/pdftk") if File.exist?("#{build_path}/bin/pdftk")
  end
end
