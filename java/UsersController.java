package test.java;

import com.annotations.ControllerAnnotation;
import com.annotations.HandleUrl;
import com.classes.ModelView;

// Contrôleur de test pour les URLs dynamiques avec paramètre de chemin
@ControllerAnnotation("/user")
public class UsersController {

    // Gère les URLs de type /user/{id} et affiche les détails d'un utilisateur
    @HandleUrl("/user/{id}")
    public ModelView showUser(int id) {
        ModelView mv = new ModelView();
        mv.setView("userDetails.jsp");
        mv.addData("id", id);
        return mv;
    }
}