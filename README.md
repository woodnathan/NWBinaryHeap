# NWBinaryHeap
An Objective-C binary heap implementation using a binary tree

## Complexity
Insert and extract operations operate in `log(n)` time where n is the number of elements in the heap.  
Examine operates in constant time.

## Future plans
* Rename some of the methods
* Change the way keys are compared
  * Thinking of using NSSortDescriptor
* Removing the key property and just sort inserted objects

## References
* http://www.comp.nus.edu.sg/~stevenha/visualization/heap.html
  * Was very useful in visualising the heap whilst implementing it
* http://commons.apache.org/proper/commons-collections/javadocs/api-2.1.1/org/apache/commons/collections/BinaryHeap.html
  * May inspire method names in the future

## License
NWBinaryHeap is available under the MIT license. See the LICENSE file for more info.