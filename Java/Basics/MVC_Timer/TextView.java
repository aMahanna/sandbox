public class TextView implements View {
	private Timer model ;
	
	public TextView (Timer model) {
		this.model = model ;
	}
	public void update() {
		System.out.println(model.toString()) ;
	}
}