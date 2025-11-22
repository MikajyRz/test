package test.java;

import com.annotations.ControllerAnnotation;
import com.annotations.HandleUrl;
import com.annotations.Param;
import com.classes.ModelView;

// Contrôleur de test pour les formulaires HTML
@ControllerAnnotation("/form")
public class FormController {

    // Reçoit les paramètres de formulaire "name" et "age" et les renvoie à une JSP
    @HandleUrl("/submit")
    public ModelView handleSubmit(@Param("name") String name, @Param("age") int age) {
        ModelView mv = new ModelView();
        mv.setView("formResult.jsp");
        mv.addData("name", name);
        mv.addData("age", age);
        return mv;
    }
}