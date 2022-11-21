locals {
    raw = file("../input.txt")
    nums = split("\n", local.raw)
    increments = [for i, num in local.nums: i > 0 ? local.nums[i] > local.nums[i - 1] ? 1 : 0 : 0]
    counts = sum(local.increments)
}

output "result" {
    value = local.counts
}