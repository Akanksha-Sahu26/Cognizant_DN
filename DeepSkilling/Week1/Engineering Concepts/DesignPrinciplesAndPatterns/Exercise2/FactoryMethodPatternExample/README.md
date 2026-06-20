# Factory Method Design Pattern - Document Management Example

This project demonstrates a simple implementation of the **Factory Method Design Pattern** in Java.

## Pattern Explanation
The Factory Method pattern defines an interface/abstract class for creating an object, but lets subclasses decide which class to instantiate.

- **`Document` (Product Interface):** Defines the common operations for all documents.
- **`WordDocument`, `PdfDocument`, `ExcelDocument` (Concrete Products):** Implement the `Document` interface.
- **`DocumentFactory` (Creator):** Declares the factory method `createDocument()`.
- **`WordDocumentFactory`, `PdfDocumentFactory`, `ExcelDocumentFactory` (Concrete Creators):** Implement `createDocument()` to return concrete document instances.

## Project Structure
- `src/com/example/factory/Document.java`
- `src/com/example/factory/WordDocument.java`
- `src/com/example/factory/PdfDocument.java`
- `src/com/example/factory/ExcelDocument.java`
- `src/com/example/factory/DocumentFactory.java`
- `src/com/example/factory/WordDocumentFactory.java`
- `src/com/example/factory/PdfDocumentFactory.java`
- `src/com/example/factory/ExcelDocumentFactory.java`
- `src/com/example/factory/FactoryMethodTest.java`

## How to Compile and Run
1. Compile the code:
   ```bash
   javac -d bin src/com/example/factory/*.java
   ```
2. Run the test:
   ```bash
   java -cp bin com.example.factory.FactoryMethodTest
   ```

## Output
```text
Opening Word document...
Closing Word document...
Opening PDF document...
Closing PDF document...
Opening Excel document...
Closing Excel document...
```
