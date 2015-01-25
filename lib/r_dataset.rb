require "r_dataset/version"
require 'r_dataset/class_methods'

module RDataset
  class RDataset
    self.extend(ClassMethods)

    def initialize(name)
      @name                   = name || 'dataset'
      @notify                 = 100
      @sample_size            = 1000
      @output_file            = 'dataset.csv'
      @include_sample_number  = false
    end

    #
    # Define the meta methods for the dataset
    #
    def message(text)
      puts "For #{@name}, #{text}"
    end

    def sample_size(size)
      message "sample size set to #{size}"
      @sample_size = size
    end

    def notify(size)
      message "notify set to #{size}"
      @notify = size
    end
    
    def output_file(output_file)
      message "output file  set to #{output_file}"
      @output_file = output_file
    end 

    def include_sample_number(true_or_false)
      text = true_or_false ? 'including sample number' : 'not including sample number'
      message text
      @include_sample_number = true_or_false
    end 

    def columns(columns = nil)
      columns ? @columns = columns : @columns
    end

    def rows(&proc)
      @rows_proc = proc
    end

    #
    #
    #
    def write_header(file)
      header = @include_sample_number ? [:no] + @columns : @columns
      header_string = header.join(',') + "\n"
      file.write(header_string)
    end


    def write_data(file)
      @sample_size.times do | no| 
        generate_row_data
        data = @include_sample_number ? [:no] + row_data : row_data
        csv_data = data.join(',') + "\n"
        file.write(csv_data)
      end       
    end

    def row_data
      @columns.collect {|column| instance_variable_get("@#{column}")}
    end

    def generate_row_data
      @rows_proc.call
    end

    def between(min,max)
      rand * (max-min) + min
    end

  end
end

