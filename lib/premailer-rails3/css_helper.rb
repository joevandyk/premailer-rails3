module PremailerRails
  module CSSHelper
    extend self

    QUERY_STRING = 'link[@type="text/css"]'

    def css_for_doc(doc)
      css = doc.search(QUERY_STRING).map { |link|
              url = link.attributes['href'].to_s
              load_css_at_path(url) unless url.blank?
            }.reject(&:blank?).join("\n")
      css
    end

    def remove_links doc
      doc.search(QUERY_STRING).each do |link|
        link.unlink
      end
      doc
    end

    private

    def load_css_at_path(path)
      # Remove everything after ? including ?
      path = path[0..(path.index('?') - 1)] if path.include? '?'
      # Remove the host
      path = path.gsub(/^https?\:\/\/[^\/]*/, '') if path.index('http') == 0

      file = path.sub("#{Rails.configuration.assets.prefix}/", '')
      Rails.application.assets.find_asset(file).to_s
    end
  end
end
