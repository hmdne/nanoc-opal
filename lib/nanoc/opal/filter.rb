# frozen_string_literal: true

module Nanoc
  module Opal
    class Filter < Nanoc::Filter
      identifier :opal

      # Runs the content through [Opal](https://opalrb.com).
      # Parameters passed as `:args` will be passed on to Opal..
      #
      # @param [String] content The content to filter
      #
      # @return [String] The filtered content
      def run(string, params = {})
        params = params.dup

        # Add current directory to the load path or something else if `load_path`
        # param is provided.
        ident = item.identifier.to_s
        fn = item.raw_filename
        dirname = File.dirname(fn)
        paths = params.delete(:load_path) || [dirname]
        paths = ::Opal.paths + paths
        params[:path_reader] = ::Opal::PathReader.new(
          paths,
          ::Opal::Builder.extensions.map { |e| [".#{e}", ".js.#{e}"] }.flatten
        )

        builder = ::Opal::Builder.new(**params)
        builder.build_str(string, fn)
        code = builder.to_s

        prefix = File.dirname(item.identifier.to_s)
        prefix += '/' unless prefix.end_with? '/'

        # Build a dependency chain
        dependencies = builder.dependent_files
        # Select only those required files that are present in our filesystem
        dependencies = dependencies.select { |i| i.start_with?(dirname) }
        # Remove the directory part up to a location of our asset
        dependencies = dependencies.map { |i| i.gsub(/\A#{dirname}\//, '') }
        # Add a prefix of our main asset (eg. /assets/js/)
        dependencies = dependencies.map { |i| prefix + i }
        # Convert that to Nanoc items
        dependencies = dependencies.map { |i| items[i] }.compact
        # Reject itself
        dependencies = dependencies.reject { |i| i == item }

        depend_on dependencies

        code
      end
    end
  end
end
