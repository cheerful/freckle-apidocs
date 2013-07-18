module Freckle
	module HTTPHeaders
		module Helpers
			STATUSES = {
        200 => '200 OK',
        201 => '201 Created',
        202 => '202 Accepted',
        204 => '204 No Content',
        205 => '205 Reset Content',
        301 => '301 Moved Permanently',
        302 => '302 Found',
        307 => '307 Temporary Redirect',
        304 => '304 Not Modified',
        401 => '401 Unauthorized',
        403 => '403 Forbidden',
        404 => '404 Not Found',
        405 => '405 Method not allowed',
        409 => '409 Conflict',
        422 => '422 Unprocessable Entity',
        500 => '500 Server Error'
      }

      def headers(status, head = {})
        css_class = (status == 204 || status == 404) ? 'headers no-response' : 'headers'
        pagination_resource = !head[:pagination_resource].nil? ? head[:pagination_resource] : 'resource'
        lines = ["Status: #{STATUSES[status]}"]
        head.each do |key, value|
          case key
            when :pagination
              lines << "Link: <https://apitest.letsfreckle.com/api/#{pagination_resource}?page=2>; rel=\"next\","
              lines << " <https://apitest.letsfreckle.com/api/#{pagination_resource}?page=5>; rel=\"last\""
            when :pagination_resource
              nil
            else lines << "#{key}: #{value}"
          end
        end

        %(<pre class="#{css_class}"><code>#{lines * "\n"}</code></pre>\n)
      end
		end
	end
end

include Freckle::HTTPHeaders::Helpers