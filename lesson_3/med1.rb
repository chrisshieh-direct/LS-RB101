def friend(friends)
  friends.select { |n| n.length == 4 } 
end

p friend(["Jimm", "Cari", "aret", "truehdnviegkwgvke", "sixtyiscooooool"])