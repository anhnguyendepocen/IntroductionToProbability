################################################################################
## Algorithms for the Grinstead & Snell Introduction to probability (1997) book
################################################################################
#
# This code is copyright 2017 of Antonello Lobianco, released under the MIT
# licence and freely available at:
# https://github.com/sylvaticus/IntroductionToProbability
#
# The book is copyright of the American Mathematical Society, released under
# the GNU Free Documentation Licence (FDL) and freely available at the same
# github repository.
# 
# The original home-page of the book seems no-longer maintained but it is still
# available at:
# http://www.dartmouth.edu/~chance/teaching_aids/books_articles/probability_book
# /book.html
# 
# This code is written in the Julia Language.
# Download a free interpreter for your Operating System on http://julialang.org
# Learn to code in Julia using a concise tutorial:
# https://www.gitbook.com/book/sylvaticus/julia-language-a-concise-tutorial/
#
# If this script requires some non-core Julia packages, you can add them running
# (only once) `Pkg.add("PkgName")`
#
# ------------------------------------------------------------------------------
# 01.08 - Horce race simulation (general)
# Simulate outcomes from a race where horses have different (user specified)
# individual probabilities to win
# ------------------------------------------------------------------------------

while true
    print("How many races to play [0 to exit] ? ")
    n = parse(Int, readline())
    if n == 0
        break
    end
    print("Please enter the probabilies of the various items, separated by space (e.g. 0.2 0.6 0.2). The sum must be 1. ")
    probString = split(readline())
    probs = Float64[]
    [push!(probs, parse(Float64,probString[i])) for i in 1:length(probString)]

    items = length(probs)
    cumProbs = copy(probs)
    [cumProbs[i]=cumProbs[i-1]+probs[i] for i in 2:items]
    wins = zeros(items)

    for i in 1:n
        r = rand()
        for j in 1:items
            if r <= cumProbs[j]
                wins[j] += 1
                break
            end
        end
    end

    println("Outcomes of the simulation:")
    for j in 1:items
        w = wins[j]
        pc = 100 * w/n
        probpc = probs[j]*100
        println("$(j): $w ($(pc) % - theorical prob $(probpc) %)")
    end

end
