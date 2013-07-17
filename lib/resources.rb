require 'json'

module Freckle
		module Resources
			module Helpers
				SIMPLE_USER = {
					"id" =>  5538,
					"email" =>  "john.test@test.com",
					"first_name" =>  "John",
					"last_name" =>  "Test",
					"avatar" => {
						"id" =>  5538,
						"thumbnail" =>  "http=> //apitest.letsfreckle.com/images/avatars/0000/0001/avatar_profile.jpg",
						"avatar" =>  "http=> //apitest.letsfreckle.com/images/avatars/0000/0001/avatar.jpg"
					},
					"url" =>  "http=> //apitest.letsfreckle.com/api/users/5538",
				}

				ACCOUNT = {
					"id" =>  3344,
					"plan_name" =>  "Freelancer",
					"subdomain" =>  "testit",
					"title" =>  "Test It! 1234",
					"address" =>  {
						"address1" =>  "1345 Main Street",
						"address2" =>  "Room 3",
						"city" =>  "Mainsville",
						"state" =>  "MA",
						"zip" =>  "12345",
						"country" =>  "USA",
						"phone" =>  "(111)-222-3333",
					},

					"ccinvoices"=>  "john.test@test.com",
					"invoicing_enabled"=>  true,
					"owner" =>  SIMPLE_USER,

					"url" =>  "http=> //apitest.letsfreckle.com/api/account/",
					"created_at" =>  "2010-06-09T20=> 44=> 57Z",
			  	"updated_at" =>  "2010-06-09T20=> 44=> 57Z",
				}

			ACCOUNT_EDITABLE_FIELDS = {
				"title" => ACCOUNT["title"],
				"address" => ACCOUNT["address"]
			}

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