require 'json'

module Freckle
	module Resources
		module Helpers
			def json(key)
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

			  %(<pre class="highlight"><code class="language-javascript">) +
			    JSON.pretty_generate(hash) + "</code></pre>"
			end
	  end
	end
end

include Freckle::Resources::Helpers