require 'compare/version'

module Compare
  class Error < StandardError; end

  class YML
    attr_accessor :source, :target, :source_file_path, :target_file_path

    def initialize source_file_path, target_file_path
      @source_file_path = source_file_path
      @target_file_path = target_file_path
      @source = File.open(source_file_path)
      @target = File.open(target_file_path)
    end

    def process
      compare
    end

    private

      def flatten_keys data, prefix = ''
        keys = []
        data.keys.each do |key|
          if data[key].is_a? Hash
            current_prefix = prefix + "#{key}."
            keys << flatten_keys(data[key], current_prefix)
          else
            keys << "#{prefix}#{key}"
          end
        end
        prefix == '' ? keys.flatten : keys
      end

      def compare
        source_yml = YAML.load(source)
        target_yml = YAML.load(target)
       
        source_keys = flatten_keys(source_yml[source_yml.keys.first])
        target_keys = flatten_keys(target_yml[target_yml.keys.first])


        compare_keys(source_keys, target_keys, source_file_path)
        compare_keys(target_keys, source_keys, target_file_path)
      end

      def compare_keys source_keys, target_keys, source_file_path
        missing = target_keys - source_keys
        file = source_file_path.split('/').last

        print_missing_keys(missing, file)
      end

      def print_missing_keys missing_keys, file
        if missing_keys.any?
          puts "Missing from #{file}:"
          missing_keys.each { |key| puts "  - #{key}" }
        else
          puts "Nothing missing from #{file}."
        end
      end

  end
end