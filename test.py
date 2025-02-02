import time
import tqdm


t0 = time.time()

s = 0
for i in tqdm.tqdm(range(5 * (10**8)), ascii=True):
    s += i

print(time.time() - t0)
