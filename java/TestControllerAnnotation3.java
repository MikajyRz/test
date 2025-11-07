package test.java;

import com.annotations.HandleUrl;

public class TestControllerAnnotation3 {
    
    @HandleUrl("/method1")
    public void method1() {}
    
    @HandleUrl("/method")
    public void pol() {}
}

