namespace DeutschAlgorithm {

    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Logical;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Random;

    @EntryPoint()
    operation Main() : Result[] {
        let results = [
            RunDeutschAlogirthm(OracleF0),
            RunDeutschAlogirthm(OracleF1),
            RunDeutschAlogirthm(OracleF2),
            RunDeutschAlogirthm(OracleF3)
        ];
        return results;
    }

    operation RunDeutschAlogirthm(oracle : ((Qubit, Qubit) => Unit)) : Result {
        use (q1, q2) = (Qubit(), Qubit());
        X(q2);
        H(q1);
        H(q2);

        oracle(q1, q2);

        H(q1);

        Reset(q2);
        return MResetZ(q1);
    }

    operation OracleF0(q1 : Qubit, q2 : Qubit) : Unit is Adj {
        // constant 0
        // f(0) = f(1) = 0
    }

    operation OracleF1(q1 : Qubit, q2 : Qubit) : Unit is Adj  {
        // constant 1
        // f(0) = f(1) = 1
        X(q2);
    }

    operation OracleF2(q1 : Qubit, q2 : Qubit) : Unit is Adj  {
        // balanced same
        // f(0) = 0, f(1) = 1
        CNOT(q1, q2);
    }

    operation OracleF3(q1 : Qubit, q2 : Qubit) : Unit is Adj {
        // balanced opposite
        // f(0) = 1, f(1) = 0
        CNOT(q1, q2);
        X(q2);
    }
}