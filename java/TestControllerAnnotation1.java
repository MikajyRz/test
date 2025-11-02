package test.java;

import com.annotations.ControllerAnnotation;
import com.annotations.HandleUrl;

@ControllerAnnotation("/controller1")
public class TestControllerAnnotation1 {
    
    @HandleUrl("/method1")
    public void method1() {}
    
    @HandleUrl("/method2")
    public void method2() {}
}

