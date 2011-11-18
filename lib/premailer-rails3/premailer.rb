module PremailerRails
  class Premailer < ::Premailer
    def initialize(html)
      # In order to pass the CSS as string to super it is necessary to access
      # the parsed HTML beforehand. To do so, the adapter needs to be
      # initialized. The ::Premailer::Adaptor handles the discovery of a
      # suitable adaptor (Nokogiri or Hpricot). To make load_html work, an
      # adaptor needs to be included and @options[:with_html_string] needs to be
      # set. For further information, refer to ::Premailer#initialize.
      @options = { :with_html_string => true }
      ::Premailer.send(:include, Adapter.find(Adapter.use))
      doc = load_html(html)

      css_string = CSSHelper.css_for_doc(doc)
      doc = CSSHelper.remove_links(doc)

      options = {
        :with_html_string => true,
        :preserve_styles => true,
        :include_style_tags => false,
        :css_string       => css_string
      }
      super(doc.to_html, options)
    end
  end
end
