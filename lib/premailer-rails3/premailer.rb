module PremailerRails
  class Premailer < ::Premailer
    def initialize(html)
      options = {
        :with_html_string => true,
        :preserve_styles => true,
        :include_style_tags => false
      }
      super(html, options)
    end
  end
end
