class JSONColumn
  def self.dump(obj)
    JSON.dump obj unless obj.nil?
  end

  def self.load(obj)
    begin
      JSON.load(obj) unless obj.nil?
    rescue JSON::ParserError
      nil
    end
  end
end