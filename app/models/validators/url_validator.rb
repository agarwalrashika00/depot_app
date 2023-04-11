class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ PHOTO_URL_REGEXP
      record.errors.add attribute, :url_format
    end
  end
end
