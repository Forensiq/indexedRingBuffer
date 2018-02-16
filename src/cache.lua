local cache = { _TYPE = 'module', _NAME = 'cache' }

function cache.new()
  local self = {
    data = {}
  }

  function self:add(key, value)
    if self:get(key) ~= nil then
      return false
    end
    self:set(key, value)
    return true
  end

  function self:set(key, value)
    self.data[key] = value
    return true
  end

  function self:get(key)
    return self.data[key]
  end

  function self:delete(key)
    self.data[key] = nil
  end

  function self:incr(key, by)
    if self.data[key] == nil then
      self:set(key, by)
    else
      self.data[key] = self:get(key) + by
    end

    return self:get(key)
  end

  function self:flush_all()
  end

  function self:flush_expired()
  end

  return self
end

return cache
