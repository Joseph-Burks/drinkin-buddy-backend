User.destroy_all

joe = User.create(username: 'Jobu', password: 'password', is_maker?: false)

karbach = User.create(
    username: 'Karbach',
    password: 'password',
    is_maker?: true,
    name: 'Karbach Brewing Company',
    address: '2032 Karbach St, Houston, TX 77092'
)

puts 'Seeded'