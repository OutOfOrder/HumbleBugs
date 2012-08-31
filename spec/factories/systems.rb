# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :system do
    user
    sequence(:name) {|n| "My System #{n}"}
    operating_system "Minix"
    processor "M68K"
    graphics_card "Matrox G900"
    graphics_driver "VESA"
    platform_list "Mac OS X"
  end
end
