# Singleton Design Pattern - Logger Example

This project demonstrates a simple implementation of the **Singleton Design Pattern** in Java.

## Pattern Explanation
The Singleton pattern restricts the instantiation of a class to a single object.
- **Private Constructor:** Prevents direct instantiation of the class with `new`.
- **Private Static Instance:** Holds the single instance.
- **Public Static Method (`getInstance()`):** Provides the access point to get the instance (lazy initialization).

## Project Structure
- `src/com/example/singleton/Logger.java` - The Singleton Logger class.
- `src/com/example/singleton/LoggerTest.java` - The Test class to verify the pattern.

## How to Compile and Run
1. Compile the code:
   ```bash
   javac -d bin src/com/example/singleton/*.java
   ```
2. Run the test:
   ```bash
   java -cp bin com.example.singleton.LoggerTest
   ```

## Output
```text
Success: Both logger1 and logger2 point to the same Logger instance.
Log: This is a log message from logger1.
Log: This is a log message from logger2.
```
