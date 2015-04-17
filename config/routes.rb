Rails.application.routes.draw do
  root 'thesis#index'

  get 'champions', to: 'champion#index'

  get 'urf/champions', to: 'champion#urf_win_loss'
  get 'urf/champions/distribution', to: 'champion#urf_win_loss_distribution'

  get 'urf/teams/level', to: 'team#level_distribution'
  get 'urf/teams/rank', to: 'team#rank_distribution'
  get 'urf/teams/rank/delta', to: 'team#rank_delta'
  get 'urf/teams/rank/upsets', to: 'team#rank_upsets'
end
