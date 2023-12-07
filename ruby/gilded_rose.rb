class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when "Aged Brie"
        update_aged_item(item)
      when "Backstage passes to a TAFKAL80ETC concert"
        update_backstage_pass_item(item)
      when "Sulfuras, Hand of Ragnaros"
        # Legendary item, no need to update
      when "Conjured Mana Cake"
        update_conjured_item(item)
      else
        update_normal_item(item)
      end
    end
  end

  private

  def update_aged_item(item)
    increase_quality(item)
    decrease_sell_in(item)
    increase_quality(item) if item.sell_in < 0
  end

  def update_backstage_pass_item(item)
    if item.sell_in > 10
      increase_quality(item)
    elsif item.sell_in > 5
      increase_quality(item, 2)
    elsif item.sell_in > 0
      increase_quality(item, 3)
    else
      item.quality = 0
    end
    decrease_sell_in(item)
  end

  def update_conjured_item(item)
    decrease_quality(item, 2)
    decrease_sell_in(item)
    decrease_quality(item, 2) if item.sell_in < 0
  end

  def update_normal_item(item)
    decrease_quality(item)
    decrease_sell_in(item)
    decrease_quality(item) if item.sell_in < 0
  end

  def increase_quality(item, value = 1)
    item.quality = [item.quality + value, 50].min
  end

  def decrease_quality(item, value = 1)
    item.quality = [item.quality - value, 0].max
  end

  def decrease_sell_in(item)
    item.sell_in -= 1
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
