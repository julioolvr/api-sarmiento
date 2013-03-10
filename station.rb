class Station
  def self.stations
    [
      'once',
      'caballito',
      'flores',
      'floresta',
      'villa_luro',
      'liniers',
      'ciudadela',
      'ramos_mejia',
      'haedo',
      'moron',
      'castelar',
      'ituzaingo',
      'padua',
      'merlo',
      'paso_del_rey',
      'moreno'
    ]
  end

  def self.beginning_station
    'moreno'
  end

  def self.ending_station
    'once'
  end

  def self.process(data)
    result = data.split('_')[2..-1]
    ret = {}
    result.each_slice(6).with_index do |slice, index|
      ret[stations[index]] = self.new(slice)
    end
    ret
  end

  def initialize(data)
    @data = data
  end

  def to_beginning
    @data[0, 3].map(&:to_i).select do |minutes|
      minutes != -1
    end
  end

  def to_end
    @data[3, 3].map(&:to_i).select do |minutes|
      minutes != -1
    end
  end

  def to_hash
    {
      "a_#{self.class.beginning_station}" => to_beginning,
      "a_#{self.class.ending_station}" => to_end
    }
  end
end