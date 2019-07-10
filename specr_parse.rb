#! /usr/bin/env ruby

require 'nokogiri'
require 'json'

def parse(in_file)
  out_file = "specs-txt/" +  File.basename(in_file, ".html") + ".txt"
  in_f = Nokogiri::HTML(open(in_file, "r"))
  out_f = open(out_file, "w")

  inc = 1
  in_f.css("td").each do |el|
    if inc > 20
      out_f.puts(el.text)
    end
    inc += 1
  end

  out_f.close
end

def parse_dir(dirname)
  Dir.glob(dirname + "/*.html") do | html_file |
    puts "working on: #{html_file}..."
    parse(html_file)
  end
end

def to_json(in_file)
  out_file = "specs-json/" + File.basename(in_file, ".txt") + ".json"
  #in_f  = open(in_file, "r")
  out_f = open(out_file, "w")

  racquet_hash = Hash.new
  fields_hash = Hash.new
  count = 0

  racquet_fields = ["name", "tension", "length", "pattern", "skip_m", "tie_m", "start_c", "tie_c"]

  File.readlines(in_file).each_with_index do |line, index|
    line = line.chomp.strip
    if index % 8 == 0
      unless fields_hash.empty?
        racquet_hash[fields_hash["name"]] = fields_hash
        fields_hash = Hash.new
        count += 1
      end
    end

    #puts "#{index}: #{line}"
    current_field = racquet_fields[index % 8]
    fields_hash[current_field] = line
  end

  racquet_hash[fields_hash["name"]] = fields_hash
  #puts racquet_hash.to_json
  out_f.write(racquet_hash.to_json)
end

def to_json_dir(dirname)
  Dir.glob(dirname + "/*.txt") do | html_file |
    puts "working on: #{html_file}..."
    to_json(html_file)
  end
end

to_json_dir("specs-txt")
#to_json("specs-txt/ASI.txt")
#parse_dir("../specr_grab/specs/")
#parse("../specr_grab/specs/BAB.html")
