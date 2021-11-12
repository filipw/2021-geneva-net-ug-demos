namespace Demos {

    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Logical;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Preparation;
    open Microsoft.Quantum.Random;

    operation HadamardWithLoopExample() : Unit {
        mutable resultsTotal = 0;
        for i in 1..4096 {
            use qubit = Qubit();
            H(qubit);
            let result = MResetX(qubit) == One ? 1 | 0;
            set resultsTotal += result;
        }
        Message($"Measured 1s: {resultsTotal}");
        Message($"Measured 0s: {4096 - resultsTotal}");
    }

    operation EntanglementWithLoopExample() : Unit {
        mutable result00 = 0;
        mutable result01 = 0;
        mutable result10 = 0;
        mutable result11 = 0;

        for i in 1..4096 {
            use (control, target) = (Qubit(), Qubit());

            H(control);
            CNOT(control, target);
            
            let resultControl = ResultAsBool(MResetZ(control));
            let resultTarget = ResultAsBool(MResetZ(target));
            if (not resultControl and not resultTarget) { set result00 += 1; }
            if (not resultControl and resultTarget) { set result01 += 1; }
            if (resultControl and not resultTarget) { set result10 += 1; }
            if (resultControl and resultTarget) { set result11 += 1; }
        }

        Message($"Measured 00: {result00}");
        Message($"Measured 01: {result01}");
        Message($"Measured 10: {result10}");
        Message($"Measured 11: {result11}");
    }    
}