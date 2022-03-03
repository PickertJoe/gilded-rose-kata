class GildedRose
  def initialize(name:, days_remaining:, quality:)
    @item = generate_item(
      name: name,
      days_remaining: days_remaining,
      quality: quality
    )
  end

  def generate_item(name:, days_remaining:, quality:)
    case name
    when "Aged Brie"
      Aged
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePass
    when "Conjured Mana Cake"
      Conjured
    when "Legendary Sulfuras, Hand of Ragnaros"
      Legendary
    else
      Item
    end.new(
      days_remaining: days_remaining,
      quality: quality
    )
  end

  def tick
    @item.tick
  end

  def days_remaining
    @item.days_remaining
  end

  def quality
    @item.quality
  end
end

class Item
  attr_reader :days_remaining, :quality

  def initialize(days_remaining:, quality:)
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    if @quality > 0
      if @days_remaining > 0 
        @quality = @quality - 1
      else
        @quality = @quality - 2
      end
    end
    @days_remaining = @days_remaining - 1
  end
end

class Aged < Item
  def tick
    if @quality < 50
      @quality = @quality + 1
      if @days_remaining <= 0
        if @quality < 50
          @quality = @quality + 1
        end
      end
    end
    @days_remaining = @days_remaining - 1
  end
end

class BackstagePass < Item
  def tick
    if @days_remaining > 0
      if @quality < 50
        if @days_remaining < 6
          @quality = @quality + 3
        elsif @days_remaining < 11
          @quality = @quality + 2
        else
          @quality = @quality + 1
        end
      end
    else
      if @quality > 0
        @quality = 0
      end
    end
    @days_remaining = @days_remaining - 1
  end
end

class Conjured < Item
  def tick
    if @quality > 0
      if @days_remaining > 0
        @quality = @quality - 2
      else
        @quality = @quality - 4
      end
    end
    @days_remaining = @days_remaining - 1
  end
end

class Legendary < Item
  def tick
    #noop
  end
end