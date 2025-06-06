using Test
function pp_dp(w::Vector{Int}, v::Vector{Int}, W::Int)
    @assert findmin(w)[1] >= 0 && findmin(v)[1] >= 0 && W >= 0
    @assert length(w) == length(v) 
    n = length(w)
    dp = zeros(Int, n+1, W+1) 
    for i in 1:n
        for j in 0:W
            if j < w[i]
                dp[i+1, j+1] = dp[i, j+1]
            else
                dp[i+1, j+1] = max(dp[i, j+1], dp[i, j - w[i] + 1] + v[i])
            end
        end
    end
    return dp[n+1, W+1]
end

function pp(w::Vector{Int}, v::Vector{Int}, W::Int)
    @assert length(w) == length(v)
    @assert findmin(w)[1] >= 0 && findmin(v)[1] >= 0 && W >= 0
    n = length(w)
    res2 = -1
    for k = 0:2^n-1
        chosen = []
        for i in 1:n
            push!(chosen, 1&k)
            k >>= 1
        end
        val = sum(chosen .* v)
        if val > res2 && sum(chosen .* w) <= W
            res2 = val
        end
    end
    return res2
end
@testset "package_problem" begin
    w = [2,3,4,7]
    v = [1,3,5,9]
    W = 10
    res1 = pp_dp(w,v,W)
    res2 = pp(w,v,W)
    @test res1 == res2
end
