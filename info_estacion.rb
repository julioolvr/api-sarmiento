class InfoEstacion
  def self.estaciones
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
      ret[estaciones[index]] = self.new(estaciones[index], slice).to_hash
    end
    ret
  end

  def initialize(nombre, data)
    @nombre = nombre
    @data = data
  end

  def siguientes_a_once
    @data[0, 3].map(&:to_i).select do |minutos|
      minutos != -1
    end
  end

  def siguientes_a_moreno
    @data[3, 3].map(&:to_i).select do |minutos|
      minutos != -1
    end
  end

  def to_hash
    {
      a_once: siguientes_a_once,
      a_moreno: siguientes_a_moreno
    }
  end
end