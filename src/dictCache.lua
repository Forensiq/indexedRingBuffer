local dictCache = { _TYPE = 'module', _NAME = 'dictCache' }

-- NOTE: nginx DICTs expire based on declared max size in memory (LRU), not total number of items.
function dictCache.new(dictName, secs)
  local self = {
    dictName = dictName,
    maxSecs = secs or 0
  }

  local cache = ngx.shared[self.dictName];

  function self:set(key, value)
    return cache:set(key, value, self.maxSecs)
  end

  function self:add(key, value)
    return cache:add(key, value, self.maxSecs)
  end

  function self:get(key)
    return cache:get(key)
  end

  function self:delete(key)
    return cache:delete(key)
  end

  function self:incr(key, by)
    -- incr only works if already initialized, boo
    local newval, err = cache:incr(key, by)

    if newval == nil then
      self.set(key, by)
      newval = by
    end

    return newval
  end

  function self:flush_all()
    cache:flush_all()
  end

  function self:flush_expired()
    cache:flush_expired()
  end

  function self:get_keys()
    return cache:get_keys()
  end

  return self
end

return dictCache
