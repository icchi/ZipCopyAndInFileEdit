# -*- encoding: UTF-8 -*-

require_relative '..\ZipCopyAndInFileEdit.rb'

begin
  return if ARGV.size < 3

  obj = ZipCopyAndInFileEdit.new
  
  # インスタンスメソッド追加
  # testFile1.txtファイルを書き換える
  def obj.testfile1txt(file_name, cnt)
    File.open(file_name, "w") do |outputFile|
      outputFile.puts("testFile")
    end
  end

  # インスタンスメソッド追加
  # testFile2.txtファイルを書き換える
  def obj.testfile2txt(file_name, cnt)
    File.open(file_name, "w") do |outputFile|
      outputFile.puts("testFile#{cnt}")
    end
  end

  obj.run(ARGV[0], ARGV[1], ARGV[2])

rescue => ex
  # 例外処理
  p "******************************"
  p "error"
  p ex
  p ex.backtrace
  p "******************************"
end