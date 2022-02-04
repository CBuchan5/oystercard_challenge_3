class Oystercard

    attr_reader :balance, :journeys, :current_journey

    LIMIT = 90
    MINIMUM = 1

    def initialize
      @balance = 0
      @in_journey = false
      @journeys = []
      @current_journey = {}
      
    end

    def top_up(value)
      fail "£#{LIMIT} limit exceeded" if balance + value > LIMIT
      @balance += value
    end

    def in_journey?
      @current_journey.count != 0
    end

    def touch_in(entry_station)
      fail "Not enough balance" if balance < MINIMUM
      @current_journey[:entry_station] = entry_station
      
    end

    def touch_out(exit_station)
      deduct(MINIMUM)
      @current_journey[:exit_station] = exit_station
      @journeys << @current_journey
      @current_journey = {}
   
    end

  private

    def deduct(value)
      @balance -= value
    end

  end
