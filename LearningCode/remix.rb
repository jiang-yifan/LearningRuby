def remix drinks

  results = []

  combo = (0...array.size).to_a.shuffle
  drinks.each.with_index do |drink, i|
    results << [ drink[0], drinks[combo[i]][1] ]
  end
  results
end

p remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
  ])
