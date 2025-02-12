require 'faker'

puts "Clearing existing books..."
Book.destroy_all

puts "Creating books..."
20.times do |i|
  Book.create!(
    title: Faker::Book.unique.title,
    author: Faker::Book.author,
    isbn: Faker::Code.isbn,
  )
  print "." if (i + 1) % 10 == 0
end

puts "\nCreated #{Book.count} books!"
