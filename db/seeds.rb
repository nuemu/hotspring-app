require 'factory_bot_rails'

10.times do
  FactoryBot.create(:hotspring, :unexplored)
  FactoryBot.create(:hotspring, :open)
end