package test.java;

import com.annotations.ControllerAnnotation;
import com.annotations.HandleUrl;

@ControllerAnnotation("/controller2")
public class TestControllerAnnotation2 {
    
    @HandleUrl("/method1")
    public void method1() {}
}

