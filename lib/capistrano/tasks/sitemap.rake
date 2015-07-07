namespace :sitemap do
  task :create do
    on roles(:app) do
      execute "cd #{current_path} && bundle exec rake sitemap:create"
    end
  end
  task :clean do
    on roles(:app) do
      execute "cd #{current_path} && bundle exec rake sitemap:clean"
    end
  end
  task :refresh do
    on roles(:app) do
      execute "cd #{current_path} && bundle exec rake sitemap:refresh"
    end
  end
end