class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ %r{\.(gif|jpg|png)\Z}i
      record.errors.add attribute, :url_format
    end
  end
end
