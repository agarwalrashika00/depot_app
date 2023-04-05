class WordCountValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless(value.split.size.between?(options[:in].first, options[:in].last))
      record.errors.add attribute, "not between range", message: "not between #{options[:in]}"
    end
  end
end