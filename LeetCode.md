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
