class Summary
  attr_accessor :incoming, :outgoing, :balance

  def initialize(transactions)
    self.incoming = transactions.find_all(&:incoming?).sum(&:amount)
    self.outgoing = transactions.find_all(&:outgoing?).sum(&:amount)
    self.balance  = self.incoming - self.outgoing
  end
end

