pragma circom 2.1.0;

template AgeProof() {
    // Private inputs
    signal input birthDate;      // Unix timestamp
    signal input currentDate;    // Unix timestamp (public or committed)
    
    // Public inputs
    signal input minAge;         // e.g., 18
    signal output valid;         // 1 = true, 0 = false

    // Calculate age
    signal age <== currentDate - birthDate;
    
    // Check if age >= minAge (in seconds)
    signal minAgeSeconds <== minAge * 365 * 24 * 60 * 60;
    
    // Output 1 if condition met
    valid <== age > minAgeSeconds ? 1 : 0;
    
    // Safety constraint
    valid * (valid - 1) === 0;
}

component main {public [minAge]} = AgeProof();