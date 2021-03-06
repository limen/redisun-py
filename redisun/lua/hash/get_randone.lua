local ks={}
local fk=false
for i,v in ipairs(KEYS) do
  if redis.call('EXISTS',v) == 1 then
    ks[#ks + 1]=v
  end
end
if #ks > 0 then
  fk=ks[math.random(#ks)]
end
if fk ~= false then
  local v=false
  local ttl=false
  if ARGV[1] == '1' then
    v=redis.call('HMGET',fk,_GET_FIELDS_)
  else
    v=redis.call('HGETALL',fk)
  end
  if ARGV[2] == '1' then
    if ARGV[3] == 'EX' then
      ttl=redis.call('TTL',fk)
    else
      ttl=redis.call('PTTL',fk)
    end
  end
  return { fk,v,ttl }
end
return nil
