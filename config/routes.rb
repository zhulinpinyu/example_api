Rails.application.routes.draw do
  resource :sessions, only: [:create, :destroy]
  resources :customers, only: [:index,:show,:create,:update,:destroy]

  match "/*path", to: proc {
    [
      204,
      {
        "Content-type" => "text/plain",
        "Access-Control-Allow-Origin" => "*",
        "Access-Control-Allow-Methods" => %w{GET POST PUT OPTIONS DELETE}.join(','),
        "Access-Control-Allow-Headers" => %w{Content-Type Accept X-User-Email X-Auth-Token}.join(',')
      },
      []
    ]
  }, via: [:options, :head]
end
