package test.java;

import com.annotations.ControllerAnnotation;
import com.annotations.HandleUrl;
import com.classes.ModelView;

@ControllerAnnotation("/user")
public class UsersController {

    @HandleUrl("/user/test")
    public ModelView showUser() {
        ModelView mv = new ModelView();
        mv.setView("userDetails.jsp");
        return mv;
    }
}