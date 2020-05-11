Rails.application.routes.draw do
  get 'messages/detail'
  root to: 'posts#detail'
  root "messages#detail"
end
