public class Book {

    // Your variables declaration here
    private String author;
    private String title;
    private int year;


    public Book (String author, String title, int year) {
        this.author = author;
        this.title = title;
        this.year = year;
    }

    public String getAuthor() {
        return author;
    }

    public String getTitle() {
        return title;
    }

    public int getYear() {
        return year;
    }

    public boolean equals(Object other) {
        Book otherBook = (Book) other;

        if (otherBook == null) {
            return false;
        } else if (otherBook == this) {
            return true;
        } else if (this.author == otherBook.author && this.title == otherBook.title && this.year == otherBook.year) {
            return true;
        } else {
            return false;
        }
    }

    public String toString() {
        return author + ": " + title + " (" + year + ")";
    }

}