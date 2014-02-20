# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'Test'
    last_name 'User'
    email 'testuser@example.com'
    password 'test1234'
    password_confirmation 'test1234'
  end
end
