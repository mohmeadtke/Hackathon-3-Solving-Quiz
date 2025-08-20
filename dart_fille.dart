Map<String, dynamic> findMissingRanges(List<int> frames) {
  int mxf = 0;
  List<List<int>> gaps = [];
  int totalframeMiss = 0;
  List<int> longest = [];
  int longestLen = 0;

  // find the max frame
  for (int f in frames) {
    if (f > mxf) mxf = f;
  }

  // mark the existing frames 
  List<bool> seen = List.filled(mxf + 1, false);
  for (int f in frames) {
    seen[f] = true;
  }

  // scan all frames to find the missing ranges 
  for (int i = 1; i <= mxf; i++) {
    if (!seen[i]) {
      int start = i;
      while (i <= mxf && !seen[i]) {
        i++;
      }
      int end = i - 1;
      gaps.add([start, end]);
      int len = end - start + 1;
      totalframeMiss += len;
      if (len > longestLen) {
        longestLen = len;
        longest = [start, end];
      }
    }
  }

  return {"gaps": gaps, "longest_gap": longest, "missing_count": totalframeMiss};
}

void main() {
  List<int> frames = [1, 2, 3, 5, 6, 10, 11, 16];
  dynamic result = findMissingRanges(frames);
  print(result);
}
