/* *
 * Use static array for NewsFeed
 * with constant MAX_SIZE
 * */

public class NewsFeed {

    private Post[] messages;
    private int size;
    public static final int MAX_SIZE = 25;

    public NewsFeed() {
    	messages = new Post[MAX_SIZE];
    }

    public void add(Post message) {
      for (int i =0;i < messages.length;i++) {
        if (messages[i] == null) {
          messages[i] = message;
          break;
        }
      }
    }

    public Post get(int index) {
	     return messages[index];
    }

    public int size() {
      size = 0;
      for (int i = 0; i < messages.length; i++) {
        if (messages[i] != null) {
          size++;
        }
      }
      return size;
    }

	  public void sort(){
			int i, j, argMin;
			Post tmp;
			for (i = 0; i < size() - 1; i++) {
				argMin = i;
				for (j = i + 1; j < size(); j++) {
					if (messages[j].compareTo(messages[argMin]) < 0) {
						argMin = j;
					}
				}

  			tmp = messages[argMin];
  			messages[argMin] = messages[i];
  			messages[i] = tmp;
		  }

	  }

  	public NewsFeed getPhotoPost(){
    	NewsFeed onlyPhotos = new NewsFeed();
      for (Post elem: messages) {
        if (elem instanceof PhotoPost) {
          onlyPhotos.add(elem);
        } 
      }
      onlyPhotos.sort();
      return onlyPhotos;
  	}

  	public NewsFeed plus(NewsFeed other) {
      NewsFeed combinedFeed = new NewsFeed();

      for (Post elem: messages) {
        combinedFeed.add(elem); 
      }

      for (Post elem2: other.messages) {
        combinedFeed.add(elem2);
      }

      combinedFeed.sort();
      return combinedFeed;

    }

}
