
module FileProcessor

  def self.read_file(input_file_name)
    File.open(input_file_name).read
  end

  def self.output(output_file_name, message)
    file = File.open(output_file_name, 'w') do |file|
      file.write(message)
    end
  end

end
