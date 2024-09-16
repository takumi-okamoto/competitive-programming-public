class Imos
    # Imos methodのためのクラス
    #
    # Imosメソッドの実装で使用される
    # 属性:
    #   data (Array): データ
    #
    # O(1)時間で区間[l, r)に値を追加し、
    # データを追加した後、各インデックスの値をO(n)時間で取得できます。
    #
    # このクラスは以下のように使用できます:
    #   data = [0]*10
    #   imos = Imos.new(data)
    #   imos.add(0, 3, 1)
    #   imos.add(2, 7, 2)
    #   imos.add(5, 8, 3)
    #   imos.get()
    #   # => [1, 1, 3, 2, 2, 5, 5, 3, 0, 4]
    #
    attr_reader :data
  
    # 初期化メソッド
    #
    # Args:
    #   data (Array): データ
    def initialize(data)
      data = data.dup
      data << 0
      @difference = []
      (data.size - 1).times { |i| @difference << data[i] - data[i-1] }
    end
  
    # 区間[l, r)にxを追加します。
    # 計算はO(1)の時間で行われます。
    #
    # Args:
    #   l (Integer): 区間の左インデックス
    #   r (Integer): 区間の右インデックス
    #   x (Integer, Float): 追加される値
    #
    # Raises:
    #   ArgumentError: rがlより大きい必要があります
    #   IndexError: インデックスが範囲外です
    def add(l, r, x)
      raise ArgumentError, 'r must be larger than l' if r < l
  
      if (0...@difference.size).cover?(l)
        @difference[l] += x
      else
        raise IndexError, "index must be in range [0, #{@difference.size})"
      end
  
      if (0...@difference.size).cover?(r)
        @difference[r] -= x
      elsif r == @difference.size
        # pass
      else
        raise IndexError, "index must be in range [0, #{@difference.size})"
      end
    end
  
    # 各インデックスの値を取得します。
    #
    # 計算はO(len(data))時間で行われます。
    #
    # Returns:
    #   Array: 各インデックスの値のリスト
    def get
      data = [@difference[0]]
      (1...@difference.size).each { |i| data << data[-1] + @difference[i] }
      data
    end
  end
  