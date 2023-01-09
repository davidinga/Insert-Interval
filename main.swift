/*
Problem:
- Given a list of sorted and non-overlapping intervals. Merge an interval
  into the list, maintaining sorted order.

Questions:
- Assume 0 <= start, <= end <= 10^5
- Assume sorted in ascending order

Thoughts:
- Insertion can take at least O(n) time because new array or shifting required.
- Find position by new interval start time.
- Collect indices of intervals to merge.
- Finish collection by new interval end time.
- Merge collection of intervals to merge.

Algorithm:
- Three edge cases: quick return
    - Intervals is empty
    - Interval.first.start > newInterval.end
    - Interval.last.end < newInterval.start
- Loop through intervals two at a time: two cases
    - Merge newInterval
        - Continue to merge with next and result.last
        - Then return result + rest of list
    - newInterval in between two intervals
        - Append newInterval + rest of list
    - Else append next interval
*/
func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
    guard intervals.count > 0 else { return [newInterval] }
    if newInterval[1] < intervals.first![0] { return [newInterval] + intervals }
    if newInterval[0] > intervals.last![1] { return intervals + [newInterval] }

    var result: [[Int]] = []

    for i in intervals.indices where i > 0 {
        let ival1 = intervals[i - 1]
        let ival2 = intervals[i]

        if ival1[0]...ival1[1] ~= newInterval[0] || ival1[0]...ival1[1] ~= newInterval[1] {
            result.append(newInterval)
            var j = i - 1
            while result.last![0]...result.last![1] ~= intervals[j][0] || result.last![0]...result.last![1] ~= intervals[j][1] {
                result[result.count - 1][0] = result.last![0] < intervals[j][0] ? result.last![0] : intervals[j][0]
                result[result.count - 1][1] = result.last![1] > intervals[j][1] ? result.last![1] : intervals[j][1]
                j += 1
            }
            return result + Array(intervals[j...])
        } else if ival1[1] < newInterval[0], newInterval[1] < ival2[0] {
            return result + [intervals[i - 1], newInterval] + Array(intervals[i...])
        } else {
            result.append(intervals[i - 1])
        }
    }

    return result
}