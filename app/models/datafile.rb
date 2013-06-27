class DataFile
  include Enumerable

  def initialize(file)
    case File.extname(file.original_filename)
    when ".csv" then @file = Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then @file = Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then @file = Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def each(&block)
    header = @file.row(1)
    (2..@file.last_row).each do |i|
      row = Hash[[header, @file.row(i)].transpose]
      if block_given?
        block.call row
      else
        yield row
      end
    end 
  end

end
