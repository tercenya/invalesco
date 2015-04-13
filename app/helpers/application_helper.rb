module ApplicationHelper
  DATA_DRAGON_VERSION = '5.7.2'

  def champion_icon(champion)
    name = case champion
    when Integer
      Champion.find(champion).key
    when String
      champion
    when Champion
      champion.key
    end

    image_tag "http://ddragon.leagueoflegends.com/cdn/#{DATA_DRAGON_VERSION}/img/champion/#{name}.png"
  end
end
