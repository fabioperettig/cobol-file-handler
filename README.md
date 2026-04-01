![COBOL](https://img.shields.io/badge/COBOL-005687?style=for-the-badge&logo=ibm&logoColor=white)
# COBOL File Handler 📂

This project is a **COBOL-based** batch application designed to read client information from a flat file, process records based on financial criteria, and generate an output file with specific data formatting.

## 🚀 Overview
**The program performs the following operations:**
- Reads input data from a client database file (CLIENTDAT.txt).
- Validates each record based on the account balance.
- Parses and Formats selected fields into a fixed-length string.
- Writes the processed results into a new output file (RECDATA.txt).
- Reports execution statistics (Total count, Valid vs. Invalid records) to the console.


## 🛠️ Technical Structure
- File Handling: Uses FILE-CONTROL with FILE STATUS tracking for robust error handling during I/O operations.
- Data Structures:
    - BOOKCLIENT: External Copybook used for standardized client record layout.

    - REC-DATA: A 15-character output record structure. <br><br>

````
FILE-CONTROL.
    SELECT CLIENTDAT ASSIGN TO "./CLIENTDAT.txt"
        FILE STATUS IS FS-CLIENTDAT.

    SELECT RECDATA ASSIGN TO "./RECDATA.txt"                 
        FILE STATUS IS FS-RECDATA.

    DATA                            DIVISION.
    FILE                            SECTION.
    FD CLIENTDAT
        RECORDING MODE IS F.
    *REGISTER obj equals 34 positions CHECK BOOKCLIENT.                                
        COPY "BOOKCLIENT".

    FD RECDATA
        RECORDING MODE IS F.
    * RECORD obj equals 15 positions.
    01 REC-DATA                     PICTURE X(15).
    
````
<br>

- Logic Flow:
    - Records with a Balance > 5900 are flagged as "Valid".
    - Records are concatenated using the STRING statement to ensure data integrity in the output.<br><br>
````
PROCEDURE                       DIVISION.

0100-MAIN-PROCEDURE             SECTION.

PERFORM 0200-INPUT-PROCEDURE.
PERFORM 0300-PROCESS-PROCEDURE UNTIL FS-CLIENTDAT EQUAL 10.
PERFORM 0400-OUTPUT-PROCEDURE.

STOP RUN.
0100-END.                       EXIT.

0200-INPUT-PROCEDURE            SECTION.
    OPEN INPUT CLIENTDAT.
    OPEN OUTPUT RECDATA.
    DISPLAY "READING DATA"
    DISPLAY "------------".

    PERFORM 0210-READ-PROCEDURE.

0200-END.                       EXIT.

0210-READ-PROCEDURE             SECTION.
    READ CLIENTDAT.
0210-END.                       EXIT.

0300-PROCESS-PROCEDURE          SECTION.

    ADD 1 TO WRK-COUNTER.

    IF REG-BALANCE GREATER 5900
        ADD 1 TO WRK-VALID
    ELSE
        ADD 1 TO WRK-UNALID
    END-IF.

    STRING REG-AGENCY           DELIMITED BY SIZE
            REG-ACCOUNT          DELIMITED BY SIZE
            REG-BALANCE          DELIMITED BY SIZE
        INTO REC-DATA.

    WRITE REC-DATA.
    IF FS-RECDATA NOT EQUAL ZEROS
        DISPLAY "ERROR WRITING DATA"  REG-AGENCY REG-ACCOUNT
    END-IF.                                         

    PERFORM 0210-READ-PROCEDURE.

0300-END.                       EXIT.
````

## 📂 File Map
| File	| Type	| Description |

|CLIENTDAT.txt	| Input	| Source file containing raw client data. |
| RECDATA.txt	Output	Processed file containing Agency, Account, and Balance.
BOOKCLIENT.cpy	Copybook	Defines the input record layout (Agency, Account, Name, Balance).

| File | Type | Description |
| :--- | :---: | ---: |
| CLIENTDAT.txt | Input | Raw data source file |
| RECDATA.txt | Output | Processed file|
| BOOKCLIENT.cpy | Copybook | Defines the input<br>record layout |

## 💻 How to Run
1. You need a COBOL compiler installed (e.g., GnuCOBOL);
2. Place CLIENTDAT.txt and BOOKCLIENT.cpy in the project root;
3. Compile it and execute it.  🚀
````
cobc -x -o clients clients.cob && ./clients
````

## 📊 Sample Output (Console)
````
READING DATA
---------------------------------------------
CLIENTS READ: 010
VALIDS: 006
UNVALIDS: 004
CLOSING PROCEDURE, GOODBYE
````

-----------

### Fabio Peretti Guimarães | APR 2026