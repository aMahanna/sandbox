import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;
import java.util.*;
import java.util.Map;
import java.util.Map.Entry;


public class GraphReader {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws IOException {
        GraphReader graphReader = new GraphReader();
        String edgesFilename = "email-dnc-edges.txt"; 
        Graph                       graph = readGraph(edgesFilename);
        List<Integer>               nodes = graph.getGraphNodes();
        Map<Integer, List<Integer>> edges = graph.getGraphEdges();

        System.out.println("Number of nodes in the Graph: " + nodes.size());

        Map<Integer, Double> pageRank = new HashMap<Integer, Double>();

        for(Integer node : nodes) {
            pageRank.put(node,1.0);   // Set each node's pageRank to 1.0 as a start
            System.out.println("Node number: " + node);
            System.out.print("Adjacent Nodes: ");
            if (edges.containsKey(node)) {
                for(Integer edge : edges.get(node)) {
                    System.out.print(edge + " ");
                }
            }
            System.out.println();
            System.out.println("------------------------------------");
        }
        
        System.out.println();
        System.out.println("Calculating pageranks...");

        int i = 0;
        while (i < 10) {
            for (Integer node : nodes) {
                graphReader.updatePR(graph, node, pageRank);
            }
            i++;
        }

        graphReader.displayResults(pageRank);

        //graphReader.printNodeDetails(graph, pageRank); used for debugging
    }

    private static Graph readGraph(String edgesFilename) throws FileNotFoundException, IOException {
        System.getProperty("user.dir");
        URL edgesPath = GraphReader.class.getClassLoader().getResource(edgesFilename);
        BufferedReader csvReader = new BufferedReader(new FileReader(edgesPath.getFile()));
        String row;
        List<Integer>               nodes = new ArrayList<Integer>();
        Map<Integer, List<Integer>> edges = new HashMap<Integer, List<Integer>>();

        boolean first = false;
        while ((row = csvReader.readLine()) != null) {
            if (!first) {
                first = true;
                continue;
            }

            String[] data = row.split(",");

            Integer u = Integer.parseInt(data[0]);
            Integer v = Integer.parseInt(data[1]);

            if (!nodes.contains(u)) {
                nodes.add(u);
            }
            if (!nodes.contains(v)) {
                nodes.add(v);
            }

            if (!edges.containsKey(u)) {
                // Create a new list of adjacent nodes for the new node u
                List<Integer> l = new ArrayList<Integer>();
                l.add(v);
                edges.put(u, l);
            } else {
                edges.get(u).add(v);
            }
        }

        for (Integer node : nodes) {
            if (!edges.containsKey(node)) {
                edges.put(node, new ArrayList<Integer>());
            }
        }

        csvReader.close();
        return new Graph(nodes, edges);
    }

    private void updatePR(Graph graph, Integer currentNode, Map<Integer, Double> pageRank) {

        Map<Integer, List<Integer>> edges = graph.getGraphEdges();
        List<Integer> nodes = graph.getGraphNodes();

        double dampingFactor = 0.85;
        double prValue = 1-dampingFactor;

        double adjacentPR; // Variable that stores the pr of the adjacent node
        double cFactor; // variable that stores the c factor of each node (outgoing links size)
        List<Integer> adjacentNodesList;

        for(Entry<Integer, List<Integer>> entry: edges.entrySet()){ // Loop through each entry of the edges Map

            adjacentNodesList = entry.getValue();                   //Stores the list of adjacent nodes of the current entry in a list

            if(adjacentNodesList.contains(currentNode)){            // Check if the currentNode is inside of the adjacent nodes list

                for (Integer edge : adjacentNodesList) {                //Iterate through all edges in the list
                    if(edge.compareTo(currentNode) == 0){               // If the current edge is equal to the current node, then update the PR (this means that the current entry points to the current node)
                        adjacentPR = pageRank.get(entry.getKey());       // This is the PR(T) in the equation
                        cFactor = adjacentNodesList.size();              // This is the C(T) in the equation
                        prValue += (dampingFactor)*(adjacentPR/cFactor); // Add into PR variable

                    }
                }
            }
        }
        pageRank.put(currentNode, prValue); // Update the node's pr value
    }

    private void displayResults(Map<Integer, Double> pageRank) {
        System.out.println();
        System.out.println("------------------------------------");
        System.out.println("Page Rank Size: " + pageRank.size());
        System.out.println();
        System.out.println("------------------------------------");
        Collection<Double> pageRankValues = pageRank.values();

        System.out.println("------------------------------------");
        System.out.print("          ");
        System.out.print("Node");
        System.out.println();
        System.out.println();

        for (int x =1; x <= 10; x++) {
            System.out.print("#" + x);
            System.out.print("        ");
            double maxValueInMap=(Collections.max(pageRankValues));  // This will return max value in the HashMap
            for (Map.Entry<Integer, Double> entry : pageRank.entrySet()) {  // Iterate through hashMap
                if (entry.getValue() == maxValueInMap) {
                    System.out.print(entry.getKey());     // Print the key with max value
                    System.out.print("        ");
                    System.out.print(maxValueInMap);
                    System.out.println();
                    System.out.println("------------------------------------------");
                    pageRankValues.remove(maxValueInMap); // Remove max value and break 2nd loop, get the next max value
                    break;
                }
            }
        }
    }

    private void printNodeDetails(Graph graph, Map<Integer, Double> pageRank) {
        List<Integer>               nodes = graph.getGraphNodes();
        Map<Integer, List<Integer>> edges = graph.getGraphEdges();

        System.out.println();
        System.out.println("------------------------------------");
        for(Integer node : nodes) {
            System.out.println("Node number: " + node);
            System.out.print("Points to: ");
            if (edges.containsKey(node)) {
                for(Integer edge : edges.get(node)) {
                    System.out.print(edge + " ");
                }
            }
            System.out.println();
            System.out.println("Current Page Rank: " + pageRank.get(node));
            System.out.println();
            System.out.println("------------------------------------");
        }

    }

}
