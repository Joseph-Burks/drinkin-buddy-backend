User.destroy_all

joe = User.create!(username: 'Jobu', password: 'password', is_maker?: false)

karbach = User.create!(
    username: 'Karbach',
    password: 'password',
    is_maker?: true,
)

puts 'Seeded'