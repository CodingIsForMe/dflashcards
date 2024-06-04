import Array "mo:base/Array";
import Int "mo:base/Int";
import Time "mo:base/Time";
actor FlashcardApp {

    // Define the flashcard type
    public type Flashcard = {
        id: Text;
        question: Text;
        answer: Text;
    };

    // Define the data structure to store flashcards
    var flashcards: [Flashcard] = [];

    // Function to create a new flashcard
    public shared func createFlashcard(question: Text, answer:Text): async Text {
        let flashcardId = "flashcard_" # Int.toText(Time.now());
        let newFlashcard = {
            id = flashcardId;
            question;
            answer;
        };
        flashcards := Array.append<Flashcard>(flashcards, [newFlashcard]);
        return flashcardId;
    };

    // Function to get a question
    public shared func getQuestion(flashcardId: Text): async Text {
      let foundFlashcard = Array.find<Flashcard>(flashcards, func (f: Flashcard) { f.id == flashcardId });
        switch (foundFlashcard) {
            case (null) { return "Flashcard not found"; };
            case (?flashcard) { return flashcard.question; };
        };
    };

    // Function to provide an answer
    public shared func provideAnswer(flashcardId: Text, answer: Text): async Text {
        switch (Array.find<Flashcard>(flashcards, func (f) { f.id == flashcardId })) {
            case (null) { return "Flashcard does not exist!"; };
            case (?flashcard) {
                if(flashcard.answer == answer){
                  return "Correct";
                };
                return "Wrong";
            };
        };
    };
}

