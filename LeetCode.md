### [最后一个单词的长度](https://leetcode-cn.com/problems/length-of-last-word/)
```
    public int lengthOfLastWord(String s) {
        // 最后一个单词左边第一个字符下标
        int leftIndex = -1;
        // 最后一个单词右边第一个字符下标
        int rightIndex = -1;
        char[] array = s.toCharArray();
        for (int i = 0; i < array.length; i++) {
            if (array[i] != ' ') {
                if (i - 1 < 0 || array[i - 1] == ' ') {
                    leftIndex = Math.max(leftIndex, i - 1);
                }
                if (i + 1 == array.length || array[i + 1] == ' ') {
                    rightIndex = Math.max(rightIndex, i + 1);
                }
            }
        }
        return Math.max(0, rightIndex - leftIndex - 1);
    }
```
### [跳跃游戏](https://leetcode-cn.com/problems/jump-game/)
```
    public boolean canJump(int[] nums) {
        if (nums.length <= 1) return true;
        int maxDis = nums[0];
        for (int i = 1; i < nums.length; i++) {
            if (i <= maxDis) {
                maxDis = Math.max(maxDis, i + nums[i]);
            }
        }
        return maxDis >= nums.length - 1;
    }
```
### [加一](https://leetcode-cn.com/problems/plus-one/)
```
    public int[] plusOne(int[] digits) {
        int index = digits.length;
        boolean canPlus = false;
        while (index > 0 && !canPlus) {
            index--;
            canPlus = digits[index] + 1 < 10;
        }
        int[] res;
        if (canPlus) {
            digits[index] = digits[index] + 1;
            res = digits;
        } else {
            res = new int[digits.length + 1];
            res[0] = 1;
        }
        for (int i = index + 1; i < res.length; i++) {
            res[i] = 0;
        }
        return res;
    }
```
### [搜索二维矩阵](https://leetcode-cn.com/problems/search-a-2d-matrix/)
二分搜索
```
    public boolean searchMatrix(int[][] matrix, int target) {
        int m = matrix.length;
        if(m == 0) return false;
        int n = matrix[0].length;
        int left = 0;
        int right = m * n;
        int mid;
       while (left < right) {
            mid = (left + right) >> 1;
            int temp = matrix[mid / n][mid % n];
            if (temp == target) {
                return true;
            } else if (mid == left) {
                break;
            } else if (temp < target) {
                left = mid;
            } else {
                right = mid;
            }
        }
        return false;
    }
```
### [颜色分类](https://leetcode-cn.com/problems/sort-colors/)
```
    public void sortColors(int[] nums) {
        if (nums == null || nums.length < 2) {
            return;
        }
        int redCount = 0;
        int blueCount = 0;
        for (int i = 0; i < nums.length - blueCount; i++) {
            if (nums[i] == 0) {
                int temp = nums[redCount];
                nums[redCount] = nums[i];
                nums[i] = temp;
                redCount++;
            } else if (nums[i] == 2) {
                int temp = nums[nums.length - blueCount - 1];
                nums[nums.length - blueCount - 1] = nums[i];
                nums[i] = temp;
                blueCount++;
                // 右侧交换过来的,也需要判断一下
                i--;
            }
        }
    }
```
### [交错字符串](https://leetcode-cn.com/problems/interleaving-string/submissions/)

tip: 慎用charAt
```
    public boolean isInterleave(String s1, String s2, String s3) {
        int length1 = s1.length();
        int length2 = s2.length();
        int length3 = s3.length();
        if (length1 + length2 != length3) return false;
        boolean[][] dp = new boolean[length1 + 1][length2 + 1];
        dp[0][0] = true;
        for (int i = 1; i < length1 + 1; i++) {
            dp[i][0] = dp[i - 1][0] && s1.charAt(i - 1) == s3.charAt(i - 1);
        }
        for (int j = 1; j < length2 + 1; j++) {
            dp[0][j] = dp[0][j - 1] && s2.charAt(j - 1) == s3.charAt(j - 1);
        }
        for (int i = 1; i < length1 + 1; i++) {
            for (int j = 1; j < length2 + 1; j++) {
                // 一定要把dp的判断放在字符判断之前减少不必要字符判断,时间能减少70%
                dp[i][j] = dp[i - 1][j] && s3.charAt(i + j - 1) == s1.charAt(i - 1)
                        || dp[i][j - 1] && s3.charAt(i + j - 1) == s2.charAt(j - 1);
            }
        }
        return dp[length1][length2];
    }
```

### 全排序
```
    private List<String> res;
    private Set<Integer> hasPicked;

    private void backTrack(int n) {
        for (int i = 1; i <= n; i++) {
            if (!hasPicked.contains(i)) {
                hasPicked.add(i);
                if (hasPicked.size() == n) {
                    StringBuilder stringBuilder = new StringBuilder();
                    for (Integer integer : hasPicked) {
                        stringBuilder.append(integer).append(" ");
                    }
                    res.add(stringBuilder.toString());
                } else {
                    backTrack(n);
                }
                hasPicked.remove(i);
            }
        }
    }

    public List<String> allSort(int n) {
        res = new ArrayList<>();
        hasPicked = new LinkedHashSet<>();
        backTrack(n);
        return this.res;
    }
```

### [N皇后](https://leetcode-cn.com/problems/n-queens/)
全排序和N皇后的问题都是可以通过回溯法去解决的,
回溯法的固有套路就是在递归选择之前先做选择然后递归选择之后再撤销选择
```
    List<List<String>> res;
    int[] queens;
    int[] hill; // 斜对角线
    int[] dale; // 主对角线
    int[] rows;
    int n;

    private boolean canPlace(int row, int col) {
        return (rows[col] + hill[row + col] + dale[row - col + n]) == 0;
    }

    private void placeQueens(int row, int col) {
        this.queens[row] = col;
        this.hill[row + col] = 1;
        this.dale[row - col + n] = 1;
        this.rows[col] = 1;
    }

    private void removeQueens(int row, int col) {
        this.queens[row] = 0;
        this.hill[row + col] = 0;
        this.dale[row - col + n] = 0;
        this.rows[col] = 0;
    }

    private void addSolution() {
        List<String> list = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            StringBuilder stringBuilder = new StringBuilder();
            for (int j = 0; j < n; j++) {
                if (j == queens[i]) {
                    stringBuilder.append('Q');
                } else {
                    stringBuilder.append('.');
                }
            }
            list.add(stringBuilder.toString());
        }
        res.add(list);
    }

    private void backTrack(int row) {
        for (int col = 0; col < n; col++) {
            if (canPlace(row, col)) {
                placeQueens(row, col);
                if (row + 1 == n) {
                    addSolution();
                } else {
                    backTrack(row + 1);
                }
                removeQueens(row, col);
            }
        }
    }


    public List<List<String>> solveNQueens(int n) {
        this.res = new ArrayList<>();
        this.n = n;
        this.rows = new int[n];
        this.hill = new int[2 * n];
        this.dale = new int[2 * n];
        this.queens = new int[n];
        backTrack(0);

        return this.res;
    }
```

### [N皇后II](https://leetcode-cn.com/problems/n-queens-ii/)

```
    boolean[] rows;
    boolean[] hills;
    boolean[] dales;
    int n;
    int count;

    private boolean canPlace(int row, int col){
        return !(rows[col] || hills[row + col] || dales[row - col + n]);
    }

    private void placeOrRemove(int row, int col,boolean place){
        rows[col] = place;
        hills[row + col] = place;
        dales[row - col + n] = place;
    }

    private void backTrack(int row){
        for(int i = 0; i < n; i++){
            if(canPlace(row, i)){
                placeOrRemove(row, i, true);
                if(row + 1 == n){
                    count ++;
                } else {
                    backTrack(row + 1);
                }
                placeOrRemove(row, i, false);
            }
        }
    }

    public int totalNQueens(int n) {
        this.n = n;
        count = 0;
        rows = new boolean[n];
        hills = new boolean[2 * n];
        dales = new boolean[2 * n];
        backTrack(0);
        return count;
    }
```

### [插入区间](https://leetcode-cn.com/problems/insert-interval/)
滑动窗口
```
    public int[][] insert(int[][] intervals, int[] newInterval) {
        // 解法思路,将newInterval当作intervals数组中的一个,完成区间合并即可
        // 通过二分查找找到对应的下标位置,在循环的时候将下标为插入数组的下标一致的
        // 数组换成插入数组进行合并,然后将后续的数组下标前移一保证都遍历到
        if(intervals == null || intervals.length == 0)return new int[][]{ newInterval };
        Arrays.sort(intervals, new Comparator<int[]>(){
            public int compare(int[] o1,int[] o2){
                return o1[0] == o2[0] ? 0 : o1[0] - o2[0];
            }
        });
        int left = 0;
        int right = intervals.length - 1;
        int mid = 0;
        // 通过二分查找找出对应的插入下标
        while(left <= right){
            mid = (left + right) >> 1;
            if(intervals[mid][0] < newInterval[0]){
                left = mid + 1;
            } else if(intervals[mid][0] > newInterval[0]){
                right = mid - 1;
            } else {
                if(newInterval[1] > intervals[mid][1]){
                    mid ++;
                }
                break;
            }
        }
        // 处理边界
        mid = Math.max(0, Math.min(mid, intervals.length - 1));
        if(intervals[mid][0] < newInterval[0]){
            // 如果二分查找没有找到相等的值,并且下标对应值比插入数组值大,则mid++
            // 这是为了保证插入的位置一定是符合大于左边,小于等于右边的原则
            mid ++;
        } 
        List<int[]> res = new ArrayList<>();
        left = Math.min(intervals[0][0], newInterval[0]);
        right = Math.min(intervals[0][1], newInterval[1]);
        for(int i = 0; i <= intervals.length; i++){
            int[] array = i == mid ? newInterval : (i > mid ? intervals[i - 1] : intervals[i]);
            if(right >= array[0]){
                right = Math.max(right, array[1]);
            } else {
                res.add(new int[]{left, right});
                left = array[0];
                right = array[1];
            }
        }
        res.add(new int[]{left, right});
        return res.toArray(new int[res.size()][2]);
    }
```
### [删除排序链表中的重复元素](https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list/submissions/)
常规
```
 public ListNode deleteDuplicates(ListNode head) {
        ListNode node = head;
        while(node != null){
            ListNode next = node.next;
            while(next != null && next.val == node.val){
                next = next.next;
            }
            node.next = next;
            node = node.next;
        }
        return head;
    }
```

### [最小路径和](https://leetcode-cn.com/problems/minimum-path-sum/)
动态规划
```
    public int minPathSum(int[][] grid) {
        if(grid == null || grid.length == 0) return 0;
        int m = grid.length;
        int n = grid[0].length;
        int[] dp = new int[n];
        for(int i = 0; i < m; i++){
            for(int j = 0; j < n; j++){
                if(i == 0 && j == 0){
                    dp[0] = grid[0][0];
                    continue;
                }
                int top = i - 1 >= 0 ? dp[j] : Integer.MAX_VALUE;
                int left = j - 1 >= 0 ? dp[j - 1] : Integer.MAX_VALUE;
                dp[j] = Math.min(top, left) + grid[i][j];
            }
        }
        return dp[n - 1];
    }
```
### [最小覆盖子串](https://leetcode-cn.com/problems/minimum-window-substring/)
滑动窗口
```
    public String minWindow(String s, String t) {
        if (s == null || t == null || s.length() < t.length()) return "";
        int[] map = new int[256];
        int left = 0;
        int right = 0;
        int start = 0;
        int end = Integer.MAX_VALUE;
        int count = t.length();
        for (char c : t.toCharArray())
            map[c]++;
        while (right < s.length()) {
            char temp = s.charAt(right);
            right++;
            if (--map[temp] >= 0) {
                count--;
            }
            while (count == 0 && map[s.charAt(left)] < 0) {
                ++map[s.charAt(left++)];
            }
            if (count == 0 && (end - start > right - left)) {
                start = left;
                end = right;
            }
        }
         return count == 0 ? s.substring(start, end) : "";
    }
```
### [只出现一次的数字](https://leetcode-cn.com/problems/single-number-ii/)
```
class Solution {
    public int singleNumber(int[] nums) {
        //记录第一次出现的数字
        int one = 0;
        //记录第二次出现的数字
        int two = 0;
        for(int num : nums){
            one = ~two & (one ^ num);
            two = ~one & (two ^ num);
        }
        return one;
    }
}
```
### [只出现一次的数字III](https://leetcode-cn.com/problems/single-number-iii/submissions/)

思路：全部数字异或之后，得出的结果即是两个只出现一次的数字的异或，这两个肯定有一位是不一样的，借助这个特点
找出不同的位数，借此将整个数组分成两份，并且这两个只出现一次会各在一个分组，这两个新分组每个只有一个出现一次的数字
这就能通过异或提取出来
```
    public int[] singleNumber(int[] nums) {
        int xorRes = 0;
        for(int i : nums){
            xorRes ^= i;
        }
        int temp = 1;
        while((xorRes & 1) != 1){
            temp <<= 1;
            xorRes >>= 1;
        }
        int x = 0;
        int y = 0;
        for(int i : nums){
            if((i & temp) > 0){
                x ^= i;
            } else {
                y ^= i;
            }
        }
        return new int[]{x,y};
    }
```

### [最大单词长度乘积](https://leetcode-cn.com/problems/maximum-product-of-word-lengths/)
思路：将每个String中包含的字符转化成二进制中的某位上的1，用于之后根据&来判断是否有相同字符。
因为会出现ab和aabb这种，所以需要传入最大长度的标志位，之后将map中的keySet，两两对比，找出
不含相同字符的两个字符串的最大的长度积
```
    public int maxProduct(String[] words) {
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < words.length; i++) {
            String single = words[i];
            char[] array = single.toCharArray();
            int sign = 0;
            for (char c : array) {
                int bit = c - 'a';
                sign |= 1 << bit;
            }
            map.put(sign, Math.max(array.length, map.getOrDefault(sign, 0)));
        }
        Set<Integer> set = map.keySet();
        int maxPro = 0;
        for (int i : set) {
            for (int j : set) {
                if ((i & j) == 0) {
                    maxPro = Math.max(maxPro, map.get(i) * map.get(j));
                }
            }
        }
        return maxPro;
    }

```

### [子集](https://leetcode-cn.com/problems/subsets/)
```
class Solution {
    List<List<Integer>> res = new LinkedList<>();
    LinkedList<Integer> selected = new LinkedList<>();

    public List<List<Integer>> subsets(int[] nums) {
        res.clear();
        selected.clear();
        int length = nums.length;
        for(int i = 0; i <= length; i++)
        backTrack(0, i, nums, length);
        return res;
    }

    void backTrack(int start,int k,int[] nums,int length){
        if(selected.size() == k){
            res.add(new LinkedList(selected));
            return;
        } 
        for(int i = start; i < length; i++){
            selected.add(nums[i]);
            backTrack(i + 1, k, nums, length);
            selected.removeLast();
        }
    }
}
```
