class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ %r{\.(gif|jpg|png)\Z}i
      record.errors.add :attribute, 'must be a URL for GIF, JPG or PNG image'
    end
  end
end