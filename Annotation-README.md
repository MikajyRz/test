# Guide de Test de l'Annotation @HandleURL

## Structure du Test

Le fichier `TestAnnotation.java` démontre comment tester l'annotation `@HandleURL` dans une classe main.

## Fonctionnalités du Test

### 1. **Classe ExampleController**
Contient des méthodes annotées avec `@HandleURL` pour simuler un contrôleur:
- `@HandleURL("/home")` - URL explicite
- `@HandleURL("/about")` - URL explicite
- `@HandleURL` - Valeur par défaut (vide)
- Méthode sans annotation pour comparaison

### 2. **Méthode main()**
Effectue les tests suivants:
- **Parcours de toutes les méthodes** de la classe
- **Détection des annotations** avec `isAnnotationPresent()`
- **Récupération des valeurs** d'annotation avec `getAnnotation()`
- **Invocation dynamique** des méthodes annotées
- **Recherche par URL** pour trouver une méthode spécifique

### 3. **Méthode utilitaire findMethodByUrl()**
Permet de rechercher une méthode par son URL (utile pour le routing)

## Comment Exécuter

### Option 1: Utiliser le script batch
```batch
test-annotation.bat
```

### Option 2: Compilation manuelle
```batch
# Compiler
javac -cp "..\Framework\build\classes;." -d build\test src\main\java\TestAnnotation.java

# Exécuter
java -cp "build\test;..\Framework\build\classes" TestAnnotation
```

## Résultat Attendu

Le test affichera:
```
=== Test de l'annotation @HandleURL ===

Nombre total de méthodes: 4

Méthode: home
  ✓ Annotée avec @HandleURL
  → URL: /home
  Page d'accueil

Méthode: about
  ✓ Annotée avec @HandleURL
  → URL: /about
  Page à propos

Méthode: defaultMethod
  ✓ Annotée avec @HandleURL
  → URL: (vide/défaut)
  Méthode avec annotation par défaut

Méthode: noAnnotation
  ✗ Pas d'annotation @HandleURL

=== Recherche de méthode par URL ===
Méthode trouvée pour l'URL '/home': home
```

## Concepts Clés de la Réflexion Java

### 1. Vérifier la présence d'une annotation
```java
if (method.isAnnotationPresent(HandleURL.class)) {
    // La méthode a l'annotation
}
```

### 2. Récupérer l'annotation
```java
HandleURL annotation = method.getAnnotation(HandleURL.class);
String url = annotation.value();
```

### 3. Parcourir toutes les méthodes
```java
Method[] methods = clazz.getDeclaredMethods();
for (Method method : methods) {
    // Traiter chaque méthode
}
```

### 4. Invoquer une méthode dynamiquement
```java
Object instance = clazz.getDeclaredConstructor().newInstance();
method.invoke(instance);
```

## Adaptation pour Votre Framework

Pour intégrer ce test dans votre `FrontServlet`:
1. Scannez les classes de votre application
2. Recherchez les méthodes annotées avec `@HandleURL`
3. Créez un mapping URL → Méthode
4. Invoquez la méthode correspondante quand une URL est demandée

## Prérequis

- Le framework doit être compilé dans `d:\ITU\S5\Framework\build\classes`
- L'annotation `@HandleURL` doit avoir `@Retention(RetentionPolicy.RUNTIME)`
