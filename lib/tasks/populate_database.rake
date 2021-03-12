namespace :populate_database do
  desc 'Populate Categories'
  task populate_categories: :environment do
    Category.create(name: 'happy-hour')
    Category.create(name: 'rock')
    Category.create(name: 'pop')
    Category.create(name: 'forro')
    Category.create(name: 'sertanejo')
    Category.create(name: 'eletronica')
    Category.create(name: 'lgbtq+')
    Category.create(name: 'musica-ao-vivo')
    Category.create(name: 'festa-na-piscina')
    Category.create(name: 'mpb')
    Category.create(name: 'ao-ar-livre')
    Category.create(name: 'praia')
    Category.create(name: 'alternativo')
    Category.create(name: 'entrada-gratis')
    Category.create(name: 'open-bar')
    Category.create(name: 'casa-de-show')
    Category.create(name: 'bar/restaurante')
  end
end
