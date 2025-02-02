## 競プロtips for Python
随時更新予定


### 整数
#### 素因数分解
`sympy` は遅いけど大体間に合う
```python
from sympy import factorint

n = 100
print(factorint(n))
# {2: 2, 5: 2}
```
#### 最大公約数, 最小公倍数
```python
from math import gcd, lcm

a, b = 12, 18
print(gcd(a, b))
# 6
print(lcm(a, b))
# 36
```

### mod 逆元
p: 素数のとき、
```python
pow(a, -1, p)
```
の形でmod p の逆元を求めることができる

#### 拡張ユークリッドの互除法

$a x + b y = \gcd(a, b)$ の解を求める
```python
def extgcd(a: int, b: int) -> tuple[int, int, int]:
    """
    ax + by = gcd(a, b) の解を返す
    """
    if b == 0:
        return a, 1, 0

    g, y, x = extgcd(b, a % b)
    y -= (a // b) * x
    return g, x, y


a, b = 12, 18
d, x, y = extgcd(a, b)
print(d, x, y)
# 6 -1 1
```

### グラフ
#### 辺の表現
1. 頂点・辺の数が大きくなる状況が多いので基本的には隣接リストを使うけれど、隣接行列で持てるときはその方が楽なことがある

#### functional graph
1. 各頂点の出次数が1のグラフのこと
1. 各連結成分には1つの閉路が存在する

### itertools
#### 組み合わせ
```python
from itertools import combinations

n = 3
for i in range(1, n):
    print(i)
    for c in combinations(range(n), i):
        print(list(c))

# 1
# [0]
# [1]
# [2]
# [3]
# 2
# [0, 1]
# [0, 2]
# [0, 3]
# [1, 2]
# [1, 3]
# [2, 3]
```

#### run length encoding
```python
from itertools import groupby

s = "aaabbbcc"
print([(k, len(list(g))) for k, g in groupby(s)])
# [('a', 3), ('b', 3), ('c', 2)]
```

#### product
```python
from itertools import product

for p in product([0, 1], [2, 3]):
    print(p)

# (0, 2)
# (0, 3)
# (1, 2)
# (1, 3)
```

#### permutations
```python
from itertools import permutations

for p in permutations([0, 1, 2]):
    print(list(p))

# [0, 1, 2]
# [0, 2, 1]
# [1, 0, 2]
# [1, 2, 0]
# [2, 0, 1]
# [2, 1, 0]
```

`more-itertools` にはdistinct permutations がある
```python
from itertools import permutations
from more_itertools import distinct_permutations

for p in permutations([0, 0, 1]):
    print(list(p))

# (0, 0, 1)
# (0, 1, 0)
# (0, 0, 1)
# (0, 1, 0)
# (1, 0, 0)
# (1, 0, 0)

for p in distinct_permutations([0, 0, 1]):
    print(list(p))

# [0, 0, 1]
# [0, 1, 0]
# [1, 0, 0]
```


### 高速化
1. ある整数が条件を満たすか（e.g. グラフのある頂点が探索済みか）を判定するとき、対象となる整数の範囲がそれほど大きくなければ、set よりlist[bool] の方が高速
1. `copy.deepcopy` は遅い
1. 2次元配列 → 1次元配列 に変換すると高速化できることがある
1. 再帰関数を書くとき、`list[Any]` のような返り値をとるのなら、`yield` を使うと高速化できることがある
