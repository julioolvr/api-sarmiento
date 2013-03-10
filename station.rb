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

  def self.process(data)
    result = data.split('_')[2..-1]
    ret = {}
    result.each_slice(6).with_index do |slice, index|
      ret[stations[index]] = self.new(stations[index], slice).to_hash
    end
    ret
  end

  def initialize(name, data)
    @name = name
    @data = data
  end

  def to_beginning
    @data[3, 3].map(&:to_i).select do |minutes|
      minutes != -1
    end
  end

  def to_end
    @data[0, 3].map(&:to_i).select do |minutes|
      minutes != -1
    end
  end

  def to_hash
    {
      a_once: to_beginning,
      a_moreno: to_end
    }
  end
end