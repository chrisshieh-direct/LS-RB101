def orient(int, hsh, sides)
  case int
  when "topright"
    return hsh
  when "botleft"
    hsh[:first] = '*'
    hsh[:second] = ' '
  when "botright"
    hsh[:first_count] = sides
    hsh[:second_count] = 0
    hsh[:ascend] = true
  when "topleft"
    hsh[:first_count] = sides
    hsh[:second_count] = 0
    hsh[:first] = '*'
    hsh[:second] = ' '
    hsh[:ascend] = true
  end
end

def triangle(int, corner)
  instructions = {
    first_count: 0, second_count: int, first: ' ', second: '*', ascend: false
  }

  orient(corner, instructions, int)

  int += 1 if corner == 'botleft' || corner == 'botright'

  int.times do
    print instructions[:first] * instructions[:first_count]
    puts instructions[:second] * instructions[:second_count]
    if instructions[:ascend] == true
      instructions[:first_count] -= 1
      instructions[:second_count] += 1
    else
      instructions[:first_count] += 1
      instructions[:second_count] -= 1
    end
  end
  puts
end

triangle(9, 'topright')
triangle(4, 'botleft')
triangle(8, 'botright')
triangle(6, 'topleft')