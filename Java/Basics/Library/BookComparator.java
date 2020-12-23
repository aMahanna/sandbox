import java.util.Comparator;

public class BookComparator implements Comparator<Book> {

    // Implement the comparator method for books.

    public int compare(Book a, Book b) {
    	if (a.getAuthor().compareTo(b.getAuthor()) == 0) {
    		
    		
    		if (a.getTitle().compareTo(b.getTitle()) == 0) {
    			

    			if (a.getYear() == b.getYear()) {
    				return 0;
    			} else if (a.getYear() < b.getYear()) {
    				return -1;
    			} else {
    				return 1;
    			}

    		} else if (a.getTitle().compareTo(b.getTitle()) > 1){

    			return 1;

    		} else {
    			return -1;
    		}

    	} else if (a.getAuthor().compareTo(b.getAuthor()) > 1) {
    		return 1;

    	} else {
    		return -1; 

    	}
    }

    

}