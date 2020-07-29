class StringHelper
  def self.sluggify(string)
    string.downcase.tr('àáäâãèéëẽêìíïîĩòóöôõùúüûũñç ', 'aaaaaeeeeeiiiiiooooouuuuunc_')
  end
end
