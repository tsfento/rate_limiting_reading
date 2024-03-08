class Rack::Attack
    Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

    throttle('req/ip', limit: 5, period: 5.seconds) do |req|
        req.ip
    end

    throttle('create_user/ip', limit: 1, period: 20.seconds) do |req|
        if req.path == '/users' && req.post?
            req.ip
        end
    end
end