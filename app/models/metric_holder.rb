class MetricHolder

  attr_accessor :name
  attr_accessor :total
  attr_accessor :success
  attr_accessor :error
  attr_accessor :max_entry_tps
  attr_accessor :max_exit_tps
  attr_accessor :last_entry_tps
  attr_accessor :last_exit_tps

  def initialize
    self.name = ""
    self.total = 0
    self.success = 0
    self.error = 0
    self.max_entry_tps = 0
    self.max_exit_tps = 0
    self.last_entry_tps = 0
    self.last_exit_tps = 0
  end

  def add_to_total (add_amt)
    self.total += add_amt
  end

  def add_to_success (add_amt)
    self.success += add_amt
  end

  def add_to_errors (add_amt)
    self.error += add_amt
  end

  def add_to_max_entry_tps (add_max)
    self.max_entry_tps += add_max
  end

  def add_to_max_exit_tps (add_max)
    self.max_exit_tps += add_max
  end

  def add_to_last_entry_tps (add_max)
    self.last_entry_tps += add_max
  end

  def add_to_last_exit_tps (add_max)
    self.last_exit_tps += add_max
  end

end

