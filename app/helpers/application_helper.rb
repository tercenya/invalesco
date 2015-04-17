module ApplicationHelper
  DATA_DRAGON_VERSION = '5.7.2'

  def champion_icon(champion)
    key = champion_key(champion)

    image_tag "http://ddragon.leagueoflegends.com/cdn/#{DATA_DRAGON_VERSION}/img/champion/#{key}.png", width: 100, height: 100
  end

  def champion_link(champion)
    key = champion_key(champion).downcase
    name = champion_name(champion)
    url = "http://gameinfo.na.leagueoflegends.com/en/game-info/champions/#{key}/"
    link_to name, url
  end

  private
  def champion_key(champion)
    case champion
    when Integer
      Champion.find(champion).key
    when String
      champion
    when Champion
      champion.key
    end
  end

  def champion_name(champion)
    champion.try(:name) || champion_key(champion)
  end
end
