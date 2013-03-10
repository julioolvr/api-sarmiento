module ApiResponses
  def self.single_station
    self.build_response(1,2,3,1,2,3)
  end

private
  def self.build_response(*minutes)
    "ok_96_#{minutes.join('_')}"
  end
end