def fan(arr_1, arr_2)
  count = 0
  arr_3 = []

  while count != arr_1.length
    arr_3 << arr_1[count]
    arr_3 << arr_2[count]
    count += 1
  end
  arr_3
end

fan([1,2,3],["x","y","z"])