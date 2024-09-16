def compute_2d_prefix_sum(matrix):
    # 行数と列数を取得
    rows = len(matrix)
    cols = len(matrix[0]) if rows > 0 else 0

    # 累積和を格納するための配列を初期化
    prefix_sum = [[0] * (cols + 1) for _ in range(rows + 1)]

    # 累積和を計算
    for i in range(1, rows + 1):
        for j in range(1, cols + 1):
            prefix_sum[i][j] = (
                matrix[i - 1][j - 1]
                + prefix_sum[i - 1][j]
                + prefix_sum[i][j - 1]
                - prefix_sum[i - 1][j - 1]
            )

    return prefix_sum


def get_submatrix_sum(prefix_sum, l1, r1, l2, r2):
    # 指定された範囲の合計を計算
    return (
        prefix_sum[r1][r2]
        - prefix_sum[l1][r2]
        - prefix_sum[r1][l2]
        + prefix_sum[l1][l2]
    )
