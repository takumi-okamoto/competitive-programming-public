def is_ok?
    true
end


def binary_search(ok, ng)
    while ok < ng - 1
        mid = (ok + ng) / 2
        if is_ok?(mid)
            ok = mid
        else
            ng = mid
        end
    end
end