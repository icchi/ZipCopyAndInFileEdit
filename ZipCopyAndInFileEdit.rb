# -*- encoding: UTF-8 -*-

require 'zip/zip'
require "tmpdir"

class ZipCopyAndInFileEdit
  public;
  # 実行
  def run(src_path, dst_directory_path, copy_count)
    return unless is_input_right?(src_path, dst_directory_path, copy_count)
    Dir.mktmpdir do |tmp_dir|
      extract(src_path, tmp_dir)
      copy(tmp_dir, dst_directory_path, copy_count,  File::extname(src_path))
    end
  end

  private;
  # 入力値を確認確認する
  def is_input_right?(src_path, dst_directory_path, copy_count)

    unless File.exist?(src_path)
      puts "Srcfile not exist"
      return false
    end

    unless File.exist?(dst_directory_path)
      puts "Dstdirectory not exist"
      return false
    end

    unless copy_count =~ /^[0-9]+$/
      puts "Input number is not number"
      return false
    end

    true
  end

  # 圧縮フォルダを解凍する
  def extract( zip, dest )
    FileUtils.makedirs(dest)
    Zip::ZipFile.foreach(zip) do |entry|
      if entry.file?
        FileUtils.makedirs("#{dest}/#{File.dirname(entry.name)}")
        entry.get_input_stream do |io|
          open( "#{dest}/#{entry.name}", "w" ) do |w|
            while ( bytes = io.read(1024)) 
              w.write bytes
            end
          end
        end
      else
        FileUtils.makedirs("#{dest}/#{entry.name}")
      end
    end
  end

  # コピーを行う
  def copy(src, dst, copy_count, extname)
    copy_count.to_i.times do |i|
      call_file_function(src, i)
      compact_zip(src, dst + format("/%03d" + extname, i + 1))
    end
  end

  # ファイル名と同じ関数を呼び出す
  def call_file_function(src_dir_path, cnt)
    Dir.glob(src_dir_path + "/*").each do |path|
      if File::ftype(path) == "directory"
        call_file_function(path, cnt)
      elsif
        method_name = File.basename(path).downcase.sub(".", "")
        self.send(method_name.intern, path, cnt) if self.methods.include?(method_name.intern)
      end
    end
  end

  # 圧縮する
  def compact_zip(src_dir_path, dst_zip_path)
    Zip::ZipFile.open(dst_zip_path, Zip::ZipFile::CREATE) do |zf|
      add_zip(src_dir_path, zf)
    end
  end

  # 圧縮用のファイル、フォルダを追加する
  def add_zip(src_dir_path, zip_obj)
    Dir.glob(src_dir_path + "/*").each do |file_path |
      if File::ftype(file_path) == "directory"
        add_zip(file_path, zip_obj)
      elsif
        zip_obj.add(File.basename(file_path), file_path)
      end
    end
  end
end
