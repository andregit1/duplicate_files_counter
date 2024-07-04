require 'digest'
require 'find'

def calculate_file_hash(file_path)
  hasher = Digest::SHA256.new
  File.open(file_path, 'rb') do |file|
    buffer = ''
    hasher.update(buffer) while file.read(1024, buffer)
  end
  hasher.hexdigest
end

def find_duplicate_files(directory_path)
  file_hash_counts = Hash.new { |hash, key| hash[key] = 0 }
  file_hash_details = Hash.new { |hash, key| hash[key] = [] }
  total_files = Dir[File.join(directory_path, '**', '*')].count { |file| File.file?(file) }
  processed_files = 0

  puts "Starting scan of directory: #{directory_path}"
  Find.find(directory_path) do |path|
    next unless File.file?(path)
    file_hash = calculate_file_hash(path)
    file_hash_counts[file_hash] += 1
    file_hash_details[file_hash] << path
    processed_files += 1
    puts "Processing file #{processed_files}/#{total_files} - #{path}"
  end
  puts "Scan completed."

  [file_hash_counts, file_hash_details]
end

def display_largest_group(file_hash_counts)
  largest_group = file_hash_counts.max_by { |hash, count| count }
  puts "Largest group: #{largest_group[0]} #{largest_group[1]}" if largest_group
end

def save_results_to_file(file_hash_counts, file_hash_details, output_directory)
  timestamp = Time.now.strftime("%Y%m%d%H%M%S")
  output_file = File.join(output_directory, "duplicate_files_report_#{timestamp}.txt")

  puts "Saving results to #{output_file}..."
  File.open(output_file, 'w') do |file|
    file.puts "Duplicate Files Report - #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}"
    file.puts "--------------------------------------------"
    file.puts "File Hashes and Counts:"
    file_hash_counts.each do |hash, count|
      file.puts "#{hash}: #{count} file(s)"
      file.puts "  Duplicated Files:"
      file_hash_details[hash].each do |file_path|
        file.puts "    #{file_path}"
      end
    end
  end
  puts "Results saved to #{output_file}."
end

if __FILE__ == $0
  if ARGV.empty?
    puts "Usage: ruby duplicate_file_counter.rb <directory_path>"
    exit
  end

  directory_path = ARGV[0]
  unless Dir.exist?(directory_path)
    puts "Directory does not exist: #{directory_path}"
    exit
  end

  file_hash_counts, file_hash_details = find_duplicate_files(directory_path)
  display_largest_group(file_hash_counts)

  output_directory = Dir.pwd
  save_results_to_file(file_hash_counts, file_hash_details, output_directory)
end
