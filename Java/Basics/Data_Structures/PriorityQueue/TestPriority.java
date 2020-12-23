public class TestPriority {

	public static void main(String[] args) {
		int time = 1;
		int priority = (new java.util.Random()).nextInt(3);
		Queue Queue = new Queue();
		Queue QueueCopy = new Queue();

		for (int i = 1; i <= 15; i++) {
			priority = (new java.util.Random()).nextInt(3);
			Queue.add(new Task(priority, i));
			QueueCopy.add(new Task(priority, i));
		}

		System.out.println("Before priority ordering...");

		while (!QueueCopy.isEmpty()) {
			Task task = QueueCopy.remove();

			System.out.println("Time: " + task.getTime() + ", priority:" + task.getPriority());
		}
		System.out.println("");

		PriorityQueue priorityQueue = new PriorityQueue();

		priorityQueue.initFromTasks(Queue);

		System.out.println("After priority ordering...");

		while (!priorityQueue.isEmpty()) {
			Task task = priorityQueue.getTask();

			System.out.println("Time: " + task.getTime() + ", priority: " + task.getPriority());
		}
	} /* main */

}
