require 'json'

module Jekyll
  class RenderJSON < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text
      @tokens = tokens
    end

    def render(object_name)
      JSON.pretty_generate(APIObjects.const_get(@text.to_s.strip.upcase))
    end

  end
end

include Jekyll::APIObjects

Liquid::Template.register_tag('render_json', Jekyll::RenderJSON)
