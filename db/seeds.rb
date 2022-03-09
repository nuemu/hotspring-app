require 'factory_bot_rails'

5.times do
  hotspring = FactoryBot.create(:hotspring)
  user = FactoryBot.create(:user)
  5.times do
    FactoryBot.create(:comment, hotspring: hotspring, user: user)
    FactoryBot.create(:post, hotspring: hotspring, user: user)
  end
end
