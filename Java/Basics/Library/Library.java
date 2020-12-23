import java.util.*;

public class Library {

    private ArrayList<Book> library = new ArrayList<Book>();

    public Book getBook(int i) {
      return library.get(i);
    }

    public int getSize() {
      return library.size();
    }

    public void addBook (Book b) {
        if (b != null) {
            library.add(b);
        }
        
    }

    public void sort() {
       library.sort(new BookComparator());
    }


    public void printLibrary() {
        for (Book elem: library) {
            System.out.println(elem);
        }
    }


}