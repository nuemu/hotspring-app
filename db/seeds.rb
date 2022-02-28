require 'factory_bot_rails'

5.times do
  FactoryBot.create(:hotspring, :unexplored)
  FactoryBot.create(:hotspring, :open)
  FactoryBot.create(:hotspring, :prohibit)
  FactoryBot.create(:hotspring, :not_exist)
end
