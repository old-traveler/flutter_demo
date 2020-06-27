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
