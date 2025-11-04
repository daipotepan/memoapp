require "csv"
while true
    puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"

    memo_type = gets.to_i # ユーザーの入力値を取得し、数字へ変換しています
    next if memo_type < 1 || memo_type > 2
    if memo_type == 1
        puts "拡張子を除いたファイルを入力してください"
        file_name = gets.chomp + ".csv"

        puts "メモしたい内容を入力してください"
        puts "完了したら CTRL + D を入力してください"
        lines = []
        begin
            while text = gets
                lines << text.chomp
            end

        rescue EOFError
        end

        i = 1

        CSV.open(file_name, "w") do |file|
            lines.each do |line|
                file << ["#{i} :" + line]
                i += 1
            end
        end

    elsif memo_type == 2
        puts "編集したいファイルを入力してください"
        file_name = gets.chomp + ".csv"

        unless File.exist?(file_name)
            puts "エラー: #{file_name} が見つかりません。"
            exit
        end

        contents = CSV.read(file_name)
        contents.each_with_index do |content, index|
            puts "#{index + 1}: #{content.join}"
        end

        while true
            puts "編集したい行番号を入力(完了したらCTRL+D)"
            text = gets
            break if text.nil?
            
            row_number = text.to_i

            next if row_number < 1 || row_number > contents.size
            puts contents[row_number - 1]

            puts "編集後の文章を入力してください"

            edit_text = gets
            contents[row_number - 1] = ["#{row_number} : " + edit_text.chomp]
            puts contents
        end

        CSV.open(file_name, "w") do |file|
            contents.each do |content|
                file << content
            end
        end
    end
end