# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Genre.find_or_create_by(genre_name: "エンジンオイル交換")
# Genre.find_or_create_by(genre_name: "洗車")
# Genre.find_or_create_by(genre_name: "その他")

# db/seeds.rb

# ニックネームの候補をカタカナで用意
nicknames = ["スピードスター", "ナビゲーター", "ロードランナー", "ギアヘッド", "ターボマスター",
             "ロードキング", "ヴェローチェ", "ドリフトマスター", "タイヤバーナー", "オートグル"]

# 車の名前の配列を用意
car_names = ["スカイライン", "セドリック", "180sx", "シルビア", "オッティ", "ワゴンＲ", "エスティマ", "デミオ",
             "ハイゼット", "キャリー", "クラウン", "スープラ", "カムリ", "プリウス", "マークⅡ", "86",
             "ラパン", "スイフト", "アコード", "N-BOX"]

# ユーザーを10人作成し、それぞれに2台の車と走行距離を作成
10.times do |n|
  user = User.create!(
    email: "user#{n+1}@example.com",
    encrypted_password: BCrypt::Password.create('1234'),  # パスワードを簡単に
    last_name: "LastName#{n+1}",
    first_name: "FirstName#{n+1}",
    last_name_kana: "ラストネーム#{n+1}",
    first_name_kana: "ファーストネーム#{n+1}",
    nickname: nicknames[n % nicknames.length],
    is_active: true
  )

  # 各ユーザーに2台の車を作成し、それぞれにランダムな走行距離を登録
  2.times do |i|
    car_name = car_names.shift
    car = CarModel.create!(
      user_id: user.id,
      name: car_name
    )

    # ランダムな走行距離を生成して登録
    DrivingDistance.create!(
      user_id: user.id,
      car_model_id: car.id,
      distance: rand(100..150000)  # 100〜150,000の間でランダム生成
    )
  end
end

# ジャンルを作成または見つける
Genre.find_or_create_by(id: 1) do |genre|
  genre.genre_name = 'エンジンオイル交換'
end

Genre.find_or_create_by(id: 2) do |genre|
  genre.genre_name = '洗車'
end

Genre.find_or_create_by(id: 3) do |genre|
  genre.genre_name = 'その他'
end

puts "10 users with 2 cars each and their driving distances have been created."
puts "Genres have been created or found."
