def to_json(in_file)
  # Need to grab 8 columns
  # 0: Racquet Name, 1: Tension, 2: Length, 3: Pattern,
  # 4: Skip M Holes, 5: Tie Off M, 6: Start C, 7: Tie Off C
  out_file = "specs-json/" + File.basename(in_file, ".txt") + ".json"
  in_f  = open(in_file, "r")
  out_f = open(out_file, "w")

  racquet = []
  racquet = IO.readlines(name=in_f)

  #puts racquet
  racquet_array = []
  next_racquet = []

  racquet_fields = ["name", "tension", "length", "pattern", "skip_m", "tie_m", "start_c", "tie_c"]

  racquet.each_with_index { |val, index|
    if index % 8 == 0
      if index != 0
        #puts "}"
        #print  "racquet:\n"
        #puts "#{val}: {"
        racquet_array.push(next_racquet)
        next_racquet = []
      end
    end
    val = val.chomp

    unless val.empty?
      puts"val: #{val}"
      next_racquet.push(val.chomp)
    end
    #racquet_array.push(next_racquet)
    #print "#{racquet_fields[index % 8]}: #{val}"
    #print racquet_array
  }

  #puts racquet.to_json

end
