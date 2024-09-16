def is_ok(mid: int) -> bool:
    pass


def binary_search_int(ok: int, ng: int) -> int:
    while ok < ng - 1:
        mid = (ok + ng) // 2
        if is_ok(mid):
            ok = mid
        else:
            ng = mid
    return ok
