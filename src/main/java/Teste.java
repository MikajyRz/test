import main.java.framework.annotations.HandleURL;

public class Teste {
    @HandleURL("/hello")
    public void hello() {}

    @HandleURL("/about")
    public void about() {}
}
