# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Genre.find_or_create_by(genre_name: "エンジンオイル交換")
Genre.find_or_create_by(genre_name: "洗車")
Genre.find_or_create_by(genre_name: "その他")