import java.util.NoSuchElementException;

public class OrderedList implements OrderedStructure {

    // Implementation of the doubly linked nodes (nested-class)

    private static class Node {

      	private Comparable value;
      	private Node previous;
      	private Node next;

      	private Node ( Comparable value, Node previous, Node next ) {
      	    this.value = value;
      	    this.previous = previous;
      	    this.next = next;
      	}
    }

    // Instance variables

    private Node head;

    // Representation of the empty list.

    public OrderedList() {
        head = new Node(null, null, null); 
        head.next = head.previous = head;
    }

    // Calculates the size of the list

    public int size() {
      Node p = head;
      int counter = 0;
      while (p.next != head) {
          p = p.next;
          counter++;
      }

      return counter;
        
    }


    public Object get(int pos) {

        if (pos < 0) { throw new IndexOutOfBoundsException(Integer.toString(pos)); }

        if (head == null) {
          throw new NoSuchElementException("Head is null");
        }
  
        Node p = head.next;
      
        for (int i = 0 ; i < pos; i++)
            if (p.next == head) {
              throw new IndexOutOfBoundsException(Integer.toString(pos));
            } else {
              p = p.next;
            }

        return p.value;
    }

    // Adding an element while preserving the order

    public boolean add(Comparable o) {

        
        if (o == null) { throw new IllegalArgumentException("null"); }
          
            
        if (head.next == head) { // LIST IS EMPTY
          
          head.next = new Node(o, head, head.next);
          return true;

        } else {
          
          Node p;
          Node q;

          p = head;
    
          while (p.next != head && p.next.value.compareTo(o) < 0) {
              p = p.next;
          }

          q = p.next; 

          p.next = new Node(o, p, q);

          q.previous = p.next; 
          return true;
        }

        
    }

    //Removes one item from the position pos.

    public void remove( int pos ) {
      
      if (pos < 0) { throw new IndexOutOfBoundsException(Integer.toString(pos)); }
        
  
      Node p = head.next;
      for (int i = 0; i < pos; i++)  { // ITERATOR
        
        if (p.next == head) {
          throw new IndexOutOfBoundsException(Integer.toString(pos)); // POS > SIZE
        } else {
          p = p.next;
        }
      }

      Node removedNode = p;  
      p = p.previous; 
      Node q = removedNode.next;
      p.next = q;
      q.previous = p;

      removedNode.value = null;
      removedNode.next = null;
      removedNode.previous = null;
        
    }


    public void merge(OrderedList o) {
      Node p = head.next;
        Node q = o.head.next;
        while(q != o.head){

          if (p == head) { 

                p.next = new Node(q.value, p, p.next);
                p = p.next;
                q = q.next;

            } else if (q.value.compareTo(p.value) == -1){

                p.previous = new Node(q.value, p.previous, p);
                p.previous.previous.next = p.previous;
                q = q.next;

            } else if (p.next == head){
                p.next = new Node(q.value, p,head);
                p = p.next;
                q = q.next;

            } else {
                p = p.next;
            }
        }
    }
}