class Oystercard

    attr_reader :balance, :entry_station, :exit_station, :journeys, :current_journey

    LIMIT = 90
    MINIMUM = 1

    def initialize
      @balance = 0
      @in_journey = false
      @journeys = []
      @current_journey = {}
      # @entry_station = station
    end

    def top_up(value)
      fail "£#{LIMIT} limit exceeded" if balance + value > LIMIT
      @balance += value
    end

    def in_journey?
      if @current_journey.count != 0
        return true
      elsif @current_journey.count == 0
        return false
      end
    end

    def touch_in(entry_station)
      fail "Not enough balance" if balance < MINIMUM
      @current_journey[:entry_station] = entry_station
      # @journeys << {entry_station: entry_station, exit_station: exit_station}
      # @in_journey = true
    end

    def touch_out(exit_station)
      deduct(MINIMUM)
      # @in_journey = false
      # @exit_station = exit_station
      @current_journey[:exit_station] = exit_station
      @journeys << @current_journey
      @current_journey = {}
      # @entry_station = nil
      
    end

  # private

    def deduct(value)
      @balance -= value
    end

  end
