/**
 * Array Heap implimentation of a (double ended) priority queue
 */
public class HeapPriorityQueue <K extends Comparable, V> implements PriorityQueue <K, V> {

	private Entry[] minStorage; // Representing the minHeap in array form
	private int minTail; // Index of last element in the minHeap

	private Entry[] maxStorage; // Representing the maxHeap in array form
	private int maxTail; // Index of last element in the maxHeap

	Entry<K, V> buffer;

	/**
	 * Default constructor
	 */
	public HeapPriorityQueue() {
		this(100);
	}

	/**
	 * HeapPriorityQueue constructor with max storage of size elements
	 */
	public HeapPriorityQueue(int size) {
		minStorage = new Entry[size / 2]; 
		maxStorage = new Entry[size / 2];
		maxTail = -1;
		minTail = -1;
	}

	/****************************************************
	 *
	 * Priority Queue Methods
	 *
	 ****************************************************/

	/**
	 * Returns the number of items in the priority queue. O(1)
	 * 
	 * @return number of items
	 */
	public int size() {
		if (buffer != null) {
			return minTail + maxTail + 3;
		}
		return minTail + maxTail + 2;
	} /* size */

	/**
	 * Tests whether the priority queue is empty. O(1)
	 * 
	 * @return true if the priority queue is empty, false otherwise
	 */
	public boolean isEmpty() {
		return size() == 0;
	} /* isEmpty */

	/**
	 * Inserts a key-value pair and returns the entry created. O(log(n))
	 * 
	 * @param key   the key of the new entry
	 * @param value the associated value of the new entry
	 * @param ref   a reference to the associated entry in the othe heap
	 * @return the entry storing the new key-value pair
	 * @throws IllegalArgumentException if the heap is full
	 */
	public Entry<K, V> insert(K key, V value) throws IllegalArgumentException {
		if (minTail == minStorage.length - 1)
			throw new IllegalArgumentException("Heap Overflow");
		if (key == null) {
			throw new IllegalArgumentException("Key is null");
		}

		if (buffer == null) { // Buffer is empty, place Entry in buffer
			buffer = new Entry<>(key, value);
			return buffer;
		}

		/*
				The following situation happens when buffer is NOT null
		*/
		Entry<K, V> e = new Entry<>(key, value); // Create an entry from the values provided
		Entry<K, V> oldBuffer = new Entry<>(buffer.key, buffer.value); // "remove" the entry in the buffer
		buffer = null; // set buffer to null
		linkAssociates(e, oldBuffer); // Link the new entry with the old buffer

		if (e.key.compareTo(oldBuffer.key) == 1) { // If the new entry is bigger than the old buffer
			// Place new entry in MAX heap
			maxStorage[++maxTail] = e; 
			e.setIndex(maxTail);
			maxUpHeap(maxTail);

			// Place old buffer in MIN heap
			minStorage[++minTail] = oldBuffer;
			oldBuffer.setIndex(minTail);
			minUpHeap(minTail);

		} else if (e.key.compareTo(oldBuffer.key) == -1) { // If the new entry is smaller than the old buffer
			// Place new entry in MIN heap
			minStorage[++minTail] = e;
			e.setIndex(minTail);
			minUpHeap(minTail);

			// Place old buffer in MAX heap
			maxStorage[++maxTail] = oldBuffer;
			oldBuffer.setIndex(maxTail);
			maxUpHeap(maxTail);

		} else {
			throw new IllegalArgumentException("ERROR: Entry Key currently exists in buffer");
		}

		return e; // Return the entry inserted
	} /* insert */

	/**
	 * Returns (but does not remove) an entry with minimal key. O(1)
	 * 
	 * @return entry having a minimal key (or null if empty)
	 */
	public Entry<K, V> min() {
		if (isEmpty())
			return null;
		return minStorage[0];
	} /* min */

	/**
	 * Removes and returns an entry with minimal key. O(log(n))
	 * 
	 * @return the removed entry (or null if empty)
	 */
	public Entry<K, V> removeMin() {
		if (isEmpty())
			return null;

		Entry<K, V> ret = minStorage[0]; // Entry to remove
		Entry<K, V> associate = ret.getAssociate(); // The associate of the entry

		if (minTail == 0) { // MIN heap only has one Entry
			minTail = -1;
			minStorage[0] = null;
			return ret;
		}

		if (buffer == null) { // There is no buffer (make associate as a buffer)
			minStorage[0] = minStorage[minTail]; // Last element of MIN heap is now at the root
			minStorage[minTail--] = null; 
			minDownHeap(0); // Downheap to fix the MIN Heap condition

			buffer = new Entry<>(associate.key, associate.value); // Associate is now placed in buffer
			buffer.setAssociate(null); // buffer should never have an associate

			// You now need to rebalance the tree, because associate needs to be removed from your maxHeap
			rebalanceMaxHeap(associate);
				
				
		} else if (buffer.key.compareTo(ret.key) < 0) { // (BUFFER IS NOT NULL) - If buffer smaller than [0] in minHeap

			Entry<K, V> temp = new Entry<>(buffer.key, buffer.value); 
			buffer = null;
			return temp; // We return the buffer, and not the root of the MIN Heap

		} else {
			int compareValue = buffer.key.compareTo(associate.key); // Compare buffer to associate in MAX HEAP

			if (compareValue == 1) { // Buffer key bigger than associate of removeMin (the associate is in maxHeap);

				// Take buffer and put it into maxHeap (at the position of the associate) (then from there, you either upheap or downheap depending on the value of the buffer key)
				Entry<K, V> tempBuffer = new Entry<>(buffer.key, buffer.value);
				tempBuffer.setIndex(associate.index);
				maxStorage[tempBuffer.index] = tempBuffer;

				// UPHEAP OR DOWNHEAP YOUR maxSTORAGE HERE 
				int parentIndex = parent(tempBuffer.index);

				if (maxStorage[parentIndex].key.compareTo(tempBuffer.key) > 0) {  // Parent is bigger than child, fix eveyrthing below with downHeap (for maxHeap)
					maxDownHeap(tempBuffer.index);
				} else if (maxStorage[parentIndex].key.compareTo(tempBuffer.key) < 0) { // Parent is smaller than child, fix everything above with upHeap (for maxHeap)
					maxUpHeap(tempBuffer.index);
				} else {
					//System.out.println("Key at index " + parentIndex + " is identical with key at index " + tempBuffer.getIndex() + " (" + tempBuffer.key + ")");
				}

				// Now take the associate and put it into the root of the minHeap, then you can downheap(0)
				Entry<K, V> newAssociate = new Entry<>(associate.key, associate.value);
				replaceMinTop(newAssociate);

				linkAssociates(tempBuffer, newAssociate); // Link Associates
				
				buffer = null; // clear buffer
				
				
			} else if (compareValue == -1) { // Buffer key smaller than associate of removeMin --> put in minHeap and downHeap
				if (minTail == minStorage.length - 1)
					throw new IllegalArgumentException("Heap Overflow");

				Entry<K, V> e = new Entry<>(buffer.key, buffer.value); // create Entry with buffer values
				linkAssociates(e, associate); // Set the new Entry (actually just the buffer)'s associate to the remove min's associate
				
				// Replace the top of the minHeap with the buffer
				replaceMinTop(e);
				

				buffer = null; // clear buffer
				

			} else {
				
			}
		} 

		ret.setAssociate(null); // just to be safe, disconect the value's associate
		return ret; // return the value that has been removed from the MIN HEAP
	} /* removeMin */

	private void rebalanceMaxHeap(Entry<K, V> associate) {
		maxStorage[associate.index] = new Entry<>(maxStorage[maxTail].key, maxStorage[maxTail].value); // replace associate with last Entry of maxStorage
		maxStorage[associate.index].setIndex(associate.index); // set the index of the new entry at the associate's place
		maxStorage[maxTail--] = null; // remove the last entry of the array (which is now at our associate's palce)
		maxDownHeap(associate.index); // Move the new Entry down until maxHeap is fixed
	}

	private void replaceMinTop(Entry<K,V> entry) {
		minStorage[0] = entry; // Replace the top of the minHeap with the entry
		entry.setIndex(0); // Set the index of the entry to 0
		minDownHeap(0); // Downheap until the minHeap is fixed
	}

	/**
	 * Returns (but does not remove) an entry with maximal key. O(1)
	 * 
	 * @return entry having a maximal key (or null if empty)
	 */
	public Entry<K, V> max() {
		if (isEmpty())
			return null;
		return maxStorage[0];
	} /* max */

	/**
	 * Removes and returns an entry with maximal key. O(log(n))
	 * 
	 * @return the removed entry (or null if empty)
	 */
	public Entry<K, V> removeMax() {
		if (isEmpty())
			return null;

		Entry<K, V> ret = maxStorage[0];
		//System.out.println("RET IS = " + ret.key);
		Entry<K, V> associate = ret.getAssociate();

		if (maxTail == 0) {
			maxTail = -1;
			maxStorage[0] = null;
			return ret;
		}

		if (buffer == null) { // There is no buffer (make associate as a buffer)
			maxStorage[0] = maxStorage[maxTail]; 
			maxStorage[maxTail--] = null;
			maxDownHeap(0);

			buffer = new Entry<>(associate.key, associate.value);
			buffer.setAssociate(null);

			// You now need to rebalance the tree, because associate needs to be removed from your minHeap: 
			rebalanceMinHeap(associate);
				
		} else if (buffer.key.compareTo(ret.key) > 0) { // if buffer bigger than root in maxHeap, remove the buffer instead
			
			Entry<K, V> temp = new Entry<>(buffer.key, buffer.value);
			buffer = null;
			return temp;

		} else { // There is an existing buffer
			
			int compareValue = buffer.key.compareTo(associate.key); // Compare buffer to associate in MIN HEAP

			if (compareValue == 1) { // Buffer key bigger than associate (Since the buffer is bigger than the min heap associate, we can leave the associate where it is and place the buffer at the top of the MAX HEAP then perform DOWN HEAP);

				if (maxTail == minStorage.length - 1)
					throw new IllegalArgumentException("Heap Overflow");

				Entry<K, V> e = new Entry<>(buffer.key, buffer.value); // create Entry with buffer values
				
				// Set the new Entry (actually just the buffer)'s associate to the remove min's associate
				linkAssociates(e, associate);
				
				// Replace the top of the minHeap with the buffer
				replaceMaxTop(e);
				
				buffer = null; // clear buffer
				
			} else if (compareValue == -1) { // Buffer key smaller than associate (So the buffer must now take the place of the associate, and the associate needs to go into the MAX HEAP)
				
				// Take buffer and put it into minHeap (at the position of the associate) (then from there, you either upheap or downheap depending on the value of the buffer key)
				Entry<K, V> tempBuffer = new Entry<>(buffer.key, buffer.value);
				tempBuffer.setIndex(associate.index);
				minStorage[tempBuffer.index] = tempBuffer;

				// UPHEAP OR DOWNHEAP YOUR min STORAGE HERE 
				int parentIndex = parent(tempBuffer.index);

				if (minStorage[parentIndex].key.compareTo(tempBuffer.key) < 0) {  // Parent is smaller than child, fix eveyrthing below with downHeap (for minHeap)
					minDownHeap(tempBuffer.index);
				} else if  (minStorage[parentIndex].key.compareTo(tempBuffer.key) > 0) { // Parent is bigger than child, fix everything above with upHeap (for minHeap)
					minUpHeap(tempBuffer.index);
				} else {
					//System.out.println("Key at index " + parentIndex + " is identical with key at index " + tempBuffer.getIndex() + " (" + tempBuffer.key + ")");
				}

				// Now take the associate and put it into the root of the maxHeap, then you can maxDownHeap(0)
				Entry<K, V> newAssociate = new Entry<>(associate.key, associate.value);

				replaceMaxTop(newAssociate);

				// The "new" associate is now in MinHeap, link it with the buffer 
				linkAssociates(newAssociate, tempBuffer);

				buffer = null; // clear buffer

			} else {

			}
		} 

		ret.setAssociate(null); // just to be safe?
		return ret;
	} /* removeMax */

	private void replaceMaxTop(Entry<K,V> entry) {
		maxStorage[0] = entry; // Replace the top of the minHeap with the entry
		entry.setIndex(0); // Set the index of the entry to 0
		maxDownHeap(0); // Downheap until the minHeap is fixed
	}

	private void rebalanceMinHeap(Entry<K,V> associate) {
		minStorage[associate.index] = new Entry<>(minStorage[minTail].key, minStorage[minTail].value); // replace associate with last Entry of storage
		minStorage[associate.index].setIndex(associate.index); // set the index of the new entry at the associate's place
		minStorage[minTail--] = null; // remove the last entry of the array (which is now at our associate's palce)
		minDownHeap(associate.index); // Move the new Entry down until minHeap is fixed
	}

	/****************************************************
	 *
	 * Methods for Heap Operations
	 *
	 ****************************************************/

	/**
	 * Algorithm to place element after insertion at the tail. O(log(n))
	 */
	private void minUpHeap(int location) {
		if (location == 0)
			return;

		int parent = parent(location);

		if (minStorage[parent].key.compareTo(minStorage[location].key) > 0) {
			minSwap(location, parent);
			minUpHeap(parent);
		}
	} /* upHeap */

	/**
	 * Algorithm to place element after insertion at the tail. O(log(n))
	 */
	private void maxUpHeap(int location) {
		if (location == 0)
			return;

		int parent = parent(location);

		if (maxStorage[parent].key.compareTo(maxStorage[location].key) < 0) {
			maxSwap(location, parent);
			maxUpHeap(parent);
		}
	} /* upHeap */

	/**
	 * Algorithm to place element after removal of root and tail element placed at
	 * root. O(log(n))
	 */
	private void minDownHeap(int location) {
		int left = (location * 2) + 1;
		int right = (location * 2) + 2;

		// Both children null or out of bound
		if (left > minTail)
			return;

		// left is in bound, right is out out;
		if (left == minTail) {
			if (minStorage[location].key.compareTo(minStorage[left].key) > 0)
				minSwap(location, left);
			return;
		}

		int toSwap = (minStorage[left].key.compareTo(minStorage[right].key) < 0) ? left : right;

		if (minStorage[location].key.compareTo(minStorage[toSwap].key) > 0) {
			minSwap(location, toSwap);
			minDownHeap(toSwap);
		}
	} /* downHeap */

	// /**
	//  * Algorithm to place element after removal of root and tail element placed at
	//  * root. O(log(n))
	//  */
	private void maxDownHeap(int location) {
		int left = (location * 2) + 1;
		int right = (location * 2) + 2;

		// Both children null or out of bound
		if (left > maxTail)
			return;

		// left in right out;
		if (left == maxTail) {
			if (maxStorage[location].key.compareTo(maxStorage[left].key) < 0)
				maxSwap(location, left);
			return;
		}

		int toSwap = (maxStorage[left].key.compareTo(maxStorage[right].key) > 0) ? left : right;

		if (maxStorage[location].key.compareTo(maxStorage[toSwap].key) < 0) {
			maxSwap(location, toSwap);
			maxDownHeap(toSwap);
		}
	} /* maxDownHeap */

	/**
	 * Link two entries as Associates
	 */
	private void linkAssociates(Entry<K,V> firstEntry, Entry<K,V> secondEntry) {
		firstEntry.setAssociate(secondEntry);  
		secondEntry.setAssociate(firstEntry); 
	}

	/**
	 * Find parent of a given location, Parent of the root is the root O(1)
	 */
	private int parent(int location) {
		return (location - 1) / 2;
	} /* parent */

	/**
	 * Inplace swap of 2 elements, assumes locations are in array (min) O(1)
	 */
	private void minSwap(int location1, int location2) {
		Entry<K, V> temp = minStorage[location1];
		minStorage[location1] = minStorage[location2];
		minStorage[location2] = temp;

		minStorage[location1].index = location1;
		minStorage[location2].index = location2;
	} /* swap */



	/**
	 * Inplace swap of 2 elements, assumes locations are in array (maxHeap) O(1)
	 */
	private void maxSwap(int location1, int location2) {
		Entry<K, V> temp = maxStorage[location1];
		maxStorage[location1] = maxStorage[location2];
		maxStorage[location2] = temp;

		maxStorage[location1].index = location1;
		maxStorage[location2].index = location2;
	} /* maxSwap */

	public void print() {
		System.out.println("MIN");

		for (int i = 0; i < size()/2; i++) {
			System.out.println("(" + minStorage[i].key.toString() + "," + minStorage[i].value.toString() + ":" + minStorage[i].index + "), ");
		}

		System.out.println();
		System.out.println();
		
		System.out.println("MAX");
	
		for (int j = 0; j < size()/2; j++) {
			System.out.println("(" + maxStorage[j].key.toString() + "," + maxStorage[j].value.toString() + ":" + maxStorage[j].index + "), ");
		}
		
	}
}