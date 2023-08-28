local functions = {}

function functions.CheckCollision(a, b)
  local ax2,ay2,bx2,by2 = a.x + a.w, a.y + a.w, b.x + b.w, b.y + b.w
  return a.x < bx2 and ax2 > b.x and a.y < by2 and ay2 > b.y
end

return functions
