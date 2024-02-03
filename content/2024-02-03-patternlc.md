+++
title = "Leetocde Pattern"
description = ""
last_modified_date = "2023-10-29"

[extra]
image = "hexcell.png"
+++



# Preface

I'll conclude some common patterns of LC, which includes the identifying symbol and important ideas of using.

# slide window & two pointers

## slide window

It always be used in the **array or string**, especially when we need to find the subarray or substring. We can use 2 pointers to control the length of window to **find the best case**.

- the length of window is fixed
- the length of window is not fixed, it can be used to find the max or min length of window

## 2 pointers

It always be used in the ordered **array or string, linkedlist**, to **find a special case**.

- slow and fast pointers
- left and right pointers

## compare
- Purpose: Two Pointers is often about finding elements in a sequence that satisfy a condition, while Sliding Window is about optimizing a subrange (like maximizing or minimizing its length while maintaining a property).
- Movement: In Two Pointers, the pointers can move independently or in coordination, sometimes in opposite directions. In Sliding Window, pointers typically move in the same direction, with the 'end' pointer leading the expansion and the 'start' pointer managing the contraction of the window.
- Two Pointers is more about pair-wise relationships and Sliding Window is about optimizing a range within the sequence.


# linked list

## edge condition

when you are required to return a new list that is the result of some operation like merging, inserting, or sorting.

Without a dummy head, you would have to write additional conditional statements to handle the initialization of the head of the result list. This is because the first element requires special handling:

- Initialization: When you start merging two lists, you don't know which list has the smallest first element. You would normally compare the first elements and then initialize the head of the result list accordingly. With a dummy head, you can skip this step.

- Empty Lists: If one or both of the input lists are empty, without a dummy head, you would need additional checks to ensure you don't attempt to access null or None elements.


# Others

- [14 patterns](https://hackernoon.com/14-patterns-to-ace-any-coding-interview-question-c5bb3357f6ed)