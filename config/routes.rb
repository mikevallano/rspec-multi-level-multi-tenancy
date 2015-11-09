class SubdomainPresent
  def self.matches?(request)
    restricted_subdomains = %w{ www admin }
    request.subdomain.present? && !restricted_subdomains.include?(request.subdomain)
  end
end

class SubdomainBlank
  def self.matches?(request)
    request.subdomain.blank?
  end
end


Rails.application.routes.draw do

  resources :memberships
  devise_for :users, :controllers => {:registrations => "registrations"}

  constraints(SubdomainPresent) do
    root 'pages#account_home', as: :subdomain_root
    get 'welcome', to: 'pages#welcome', as: :welcome

    resources :projects do
      resources :posts
    end

  end

  constraints(SubdomainBlank) do
    root 'pages#home'
    get 'pages/about'
    resources :accounts
  end

end
