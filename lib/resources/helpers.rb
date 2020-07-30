require 'json'

module Noko
  module Resources
    module Helpers
      API_HOST = "https://api.nokotime.com/"
      TOKEN    = "scbp72wdc528hm8n52fowkma321tn58-jc1l2dkil0pnb75xjni48ad2wwsgr1d"

      def api_call method, path
        method_name = method.to_s.upcase
        %(<pre class="highlight"><code class="language-sh">) +
        "#{method_name} #{path}" + "\n\n" +
        curl_example(method, path) + "\n" +
        "</code></pre>"
      end

      def curl_example method, path
        path = path[1..-1] if path =~ /^\//
        command = ""
        command = "-X POST " if method == :post
        command = "-X PUT " if method == :put
        command = "-X DELETE " if method == :delete
        "# cURL\n$ curl #{command}-H \"X-NokoToken:#{TOKEN}\" #{API_HOST}#{path}"
      end

      def json_array(key)
        %(<pre class="highlight"><code class="language-javascript">) +
          JSON.pretty_generate([generate_hash(key)]) + "</code></pre>"
      end

      def json(key)
        %(<pre class="highlight"><code class="language-javascript">) +
          JSON.pretty_generate(generate_hash(key)) + "</code></pre>"
      end

      def code_block_start_tag_custom_language(language)
        %(<pre class="highlight"><code class="#{language}">)
      end

      def code_block_start_tag(language)
        %(<pre class="highlight"><code class="language-#{language}">)
      end

      def code_block_end_tag
        %(</code></pre>)
      end

      def generate_hash(key)
        hash = case key
          when Hash
            h = {}
            key.each { |k, v| h[k.to_s] = v }
            h
          when Array
            key
          else Resources.const_get(key.to_s.upcase)
        end

        hash = yield hash if block_given?

        return hash
      end


      def openapi_specification
        JSON.pretty_generate(generate_hash(OPENAPI_SPEC))
      end
    end
  end
end

include Noko::Resources::Helpers
