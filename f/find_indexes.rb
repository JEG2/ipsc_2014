require "pstore"

BASE_URL    = "http://piworld.calico.jp/value/pi-100b/"
FILE_FORMAT = "pi-%04d.zip"
file_count  = 1
digits      = "3"
indexes     = PStore.new("indexes.pstore")

loop do
  puts "Downloading..."
  file          = FILE_FORMAT % file_count
  unzipped_file = File.basename(file, ".zip") + ".txt"
  unless File.exist?(file)
    system("curl -O #{BASE_URL}#{file}") or abort "Download failed"
  end
  unless File.exist?(unzipped_file)
    system("unzip #{file}")              or abort "Unzip failed"
  end

  data = File.read(unzipped_file)
  data.gsub!(/:\s+\d+\s+/, "")
  data.delete!("^0-9")
  digits << data

  puts "Searching..."
  indexes.transaction do
    digits.length.times do |i|
      sequence = digits[i, 9]
      if indexes.root?(sequence) && indexes[sequence].nil?
        indexes[sequence] = i
      end
      puts "#{i} of #{digits.size}" if i % 100_000 == 0
    end
  end

  break
  file  += 1
  digits = digits[-8..-1]
end
