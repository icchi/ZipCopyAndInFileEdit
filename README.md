ZipCopyAndInFileEdit
=============

・zipファイルを指定数コピーする
・コピー時にzipファイル内のファイルを書き換えることが出来る

使い方
-------

1. ZipCopyAndInFileEditクラスのインスタンスを作成
2. zipファイル内のファイルを書き換える場合は
　 ZipCopyAndInFileEditのインスタンスにインスタンスメソッドを追加します。
　　⇒追加のルールは以下のとおりです。
　　　・変更したいファイル名を関数にする
　　　　・全て小文字
　　　　・「.」は省く
　　　　・引数は2つ(ファイル名, コピー回数)
　　　・例)testFile1.txt　⇒　testfile1txt(file_name, cnt)
3. 追加したインスタンスメソッド内でファイルを編集してください
4. ZipCopyAndInFileEdit#runメソッドで実行します。
