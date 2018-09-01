local vs = {}
local ttl = redis.call('TTL',KEYS[1])
local lt = tonumber(ARGV[3])
for i,k in ipairs(KEYS) do
  if lt == 0 and ttl>0 then
    vs[i] = {k,redis.call('SET',k,ARGV[1],ARGV[2],ttl,ARGV[4])}
  elseif lt>0 then
    vs[i] = {k,redis.call('SET',k,ARGV[1],ARGV[2],lt,ARGV[4])}
  else
    vs[i] = {k,redis.call('SET',k,ARGV[1],ARGV[4])}
  end 
end
return vs