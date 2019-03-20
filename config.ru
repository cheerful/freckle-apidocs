use Rack::Static, :urls => [""], :root => 'public', :index => 'index.html'
run Proc.new { |env| ['404', {'Content-Type' => 'text/html'}, ['nope']] }