every 1.hour do
  rake "crawlers:run_socks"
  rake "crawlers:run_static"
end
