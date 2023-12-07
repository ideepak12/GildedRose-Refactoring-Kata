require_relative 'gilded_rose'

describe GildedRose do
  describe "#update_quality" do
    context "for Aged Brie" do
      it "increases in quality over time" do
        items = [Item.new("Aged Brie", 5, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 11
      end

      it "quality does not exceed 50" do
        items = [Item.new("Aged Brie", 5, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

      it "increases in quality after sell_in date" do
        items = [Item.new("Aged Brie", 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 12
      end
    end

    context "for Backstage passes" do
      it "increases in quality as sell_in approaches" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 11
      end

      it "quality increases by 2 when there are 10 days or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 12
      end

      it "quality increases by 3 when there are 5 days or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 13
      end

      it "quality drops to 0 after the concert" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context "for Sulfuras" do
      it "does not change sell_in and quality" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 5
        expect(items[0].quality).to eq 80
      end
    end

    context "for Conjured items" do
      it "degrades in quality twice as fast as regular items" do
        items = [Item.new("Conjured Mana Cake", 5, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 8
      end

      it "quality degrades twice as fast after sell_in date" do
        items = [Item.new("Conjured Mana Cake", 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 6
      end

      it "quality does not go negative" do
        items = [Item.new("Conjured Mana Cake", 5, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context "for regular items" do
      it "does not change the name" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].name).to eq "foo"
      end

      it "decreases sell_in and quality by 1" do
        items = [Item.new("foo", 5, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 4
        expect(items[0].quality).to eq 9
      end

      it "quality degrades twice as fast after sell_in date" do
        items = [Item.new("foo", 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 8
      end

      it "quality does not go negative" do
        items = [Item.new("foo", 5, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end
  end
end
