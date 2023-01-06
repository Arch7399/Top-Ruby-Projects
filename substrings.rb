dict = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substr(text, votes)
text = text.downcase
votes.reduce(Hash.new(0)) do |accum, dty|
if text.include?(dty)
accum[dty] += text.scan(dty).size
end
accum
end
end

p substr("Howdy partner, sit down! How's it going?", dict)