require 'factory_bot_rails'

5.times do
  hotspring = FactoryBot.create(:hotspring)
  user = FactoryBot.create(:user)

  FactoryBot.create(:comment, hotspring: hotspring, user: user)
  FactoryBot.create(:post, hotspring: hotspring, user: user)
end

5.times do
  hotspring = FactoryBot.create(:hotspring, :prohibit)
  user = FactoryBot.create(:user)

  FactoryBot.create(:comment, hotspring: hotspring, user: user)
  FactoryBot.create(:post, hotspring: hotspring, user: user)
end

5.times do
  hotspring = FactoryBot.create(:hotspring, :unexplored)
  user = FactoryBot.create(:user)

  FactoryBot.create(:comment, hotspring: hotspring, user: user)
  FactoryBot.create(:post, hotspring: hotspring, user: user)
end
