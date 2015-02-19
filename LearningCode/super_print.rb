def super_print string, options = {}
  defaults = { times: 1, upcase: false, reverse: false }

  defaults.merge!(options)

  string.upcase! if defaults[:upcase]
  string.reverse! if defaults[:reverse]
  string * defaults[:times]

end

p super_print("Hello", {})
