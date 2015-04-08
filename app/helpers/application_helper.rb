module ApplicationHelper
  def champion_icon(name_or_id)
    name = name_or_id.is_a?(Integer) ? Champion.find(name_or_id) : name_or_id.to_s
    image_tag "http://ddragon.leagueoflegends.com/cdn/5.2.1/img/champion/#{name}.png"
  end
end
