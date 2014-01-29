require 'json'

module Freckle
	module Resources
		module Helpers
			def json_array(key)
				%(<pre class="highlight"><code class="language-javascript">) +
			    JSON.pretty_generate([generate_hash(key)]) + "</code></pre>"
			end

			def json(key)
			  %(<pre class="highlight"><code class="language-javascript">) +
			    JSON.pretty_generate(generate_hash(key)) + "</code></pre>"
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
	  end
	end
end

include Freckle::Resources::Helpers