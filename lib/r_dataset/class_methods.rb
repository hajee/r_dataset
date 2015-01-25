module RDataset
  module ClassMethods
    def define(name = nil, &definition)
      @instance   = self.new(name)
      @definition = definition
      read_dataset_definition
      define_columns
      evaluate_definition
    end  

    def read_dataset_definition
      @instance.instance_eval(&@definition)
    end

    def evaluate_definition
      @instance.instance_eval do
        open(@output_file, 'w') do | file|
          write_header(file)
          write_data(file)
        end
      end
    end

    def define_columns
      @instance.columns.each do | col |
        @instance.instance_eval(<<-END_RUBY, __FILE__, __LINE__)
          def #{col}(value = nil)
            value ? @#{col}=value : @#{col}
          end
        END_RUBY
      end
    end
  end
end
