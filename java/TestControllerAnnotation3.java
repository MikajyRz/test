package test.java;

import com.annotations.HandleUrl;
import com.classes.ModelView;

public class TestControllerAnnotation3 {
    
    @HandleUrl("/nonn")
    public void method1() {}
    
    @HandleUrl("/testnonn")
    public ModelView method18() {
        ModelView mvw = new ModelView();
        mvw.setView("index.html");
        return mvw;
    }
}

