require 'compare/version'
require 'yaml'
require 'json'

module Compare
  class Error < StandardError; end

  class YML
    attr_accessor :source, :target, :source_file_path, :target_file_path

    FILE_EXTS_NORMALIZED = {
      json: :json,
      yaml: :yml,
      yml: :yml,
      YML: :yml,
      JSON: :json
    }

    def initialize source_file_path, target_file_path
      @source_file_path = source_file_path
      @target_file_path = target_file_path
    end

    def process
      unless (validate_source && validate_target)
        puts 'Exiting...'
        return
      end
      
      @source = File.open(source_file_path) if validate_source
      @target = File.open(target_file_path) if validate_target
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
        source_yml = load_file(source, source_file_path)
        target_yml = load_file(target, target_file_path)

        source_keys = flatten_keys(get_normalized_data(source_yml))
        target_keys = flatten_keys(get_normalized_data(target_yml))

        compare_keys(source_keys, target_keys, source_file_path)
        compare_keys(target_keys, source_keys, target_file_path)
      end

      def get_normalized_data data
        # if this is language translation file, the first line would be en: or de: or ar:, but we dont want to compare that
        if data.keys.first.length == 2 && data.keys.length == 1
          data[data.keys.first]
        else
          data
        end
      end

      def compare_keys source_keys, target_keys, source_file_path
        missing = target_keys - source_keys
        print_missing_keys(missing, source_file_path)
      end

      def load_file file, file_path
        ext = file_path.split('.').last
        normalized_ext = FILE_EXTS_NORMALIZED[ext.to_sym]
        
        file_contents_as_string = file.read
        file.close

        if normalized_ext == :json
          ::JSON.parse(file_contents_as_string)
        elsif normalized_ext == :yml
          ::YAML.load(file_contents_as_string)
        else
          puts "File extension '#{ext}'' is not supported."
        end
      end

      def print_missing_keys missing_keys, file
        if missing_keys.any?
          puts "Missing from #{file}:"
          missing_keys.each { |key| puts "  - #{key}" }
          puts ""
        else
          puts "Nothing missing from #{file}."
        end
      end

      def validate_source
        validate_file(source_file_path, 'source')
      end

      def validate_target
        validate_file(target_file_path, 'target')
      end

      def validate_file file, file_type
        if file.nil? || file.empty?
          puts "We need a #{file_type} file to work with."
          return false
        end
        true
      end

  end
end
