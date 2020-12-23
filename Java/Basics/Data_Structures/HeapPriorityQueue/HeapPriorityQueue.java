public class HeapPriorityQueue<K extends Comparable, V> implements PriorityQueue<K, V> {

	private Entry[] storage;
	private int tail;

	public HeapPriorityQueue() {
		this(100);
	}

	public HeapPriorityQueue(int size) {
		storage = new Entry[size];
		tail = -1;
	}

	public int size() {
		return tail + 1;
	}

	public boolean isEmpty() {
		return tail < 0;
	}

	public Entry<K, V> insert(K key, V value) throws IllegalArgumentException {
		if (tail == storage.length - 1)  {
			throw new IllegalArgumentException("Overflow in Heap");
		}

		Entry<K, V> e = new Entry<>(key, value);
		storage[++tail] = e;
		upHeap(tail);
		return e;
	}

	public Entry<K, V> min() {
		if (isEmpty()) {
			return null;
		}
		return storage[0];
	} /* min */

	public Entry<K, V> removeMin() {
		if (isEmpty()) {
			return null;
		}

		Entry<K, V> ret = storage[0];

		if (tail == 0) {
			tail = -1;
			storage[0] = null;
			return ret;
		}

		storage[0] = storage[tail];
		storage[tail--] = null;

		downHeap(0);

		return ret;
	}

	private void upHeap(int loc) {
		if (loc == 0)
			return;

		int parent = parent(loc);

		if (storage[parent].key.compareTo(storage[loc].key) > 0) {
			swap(loc, parent);
			upHeap(parent);
		}
	}

	private void downHeap(int loc) {
		int left = (loc * 2) + 1;
		int right = (loc * 2) + 2;

		if (left > tail)
			return;
			
		if (left == tail) {
			if (storage[loc].key.compareTo(storage[left].key) > 0)
				swap(loc, left);
			return;
		}

		int toSwap = (storage[left].key.compareTo(storage[right].key) < 0) ? left : right;

		if (storage[loc].key.compareTo(storage[toSwap].key) > 0) {
			swap(loc, toSwap);
			downHeap(toSwap);
		}
	}

	private int parent(int loc) {
		return (loc - 1) / 2;
	}

	private void swap(int loc1, int loc2) {
		Entry<K, V> temp = storage[loc1];
		storage[loc1] = storage[loc2];
		storage[loc2] = temp;
	}

}
