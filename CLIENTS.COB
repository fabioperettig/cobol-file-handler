       IDENTIFICATION                  DIVISION.
       PROGRAM-ID.                     CLIENTS.
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.

       INPUT-OUTPUT                    SECTION.
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
      
      
       WORKING-STORAGE                 SECTION.
       01 INPUTMENU                    PICTURE 9(01).
       01 FS-CLIENTDAT                 PICTURE X(02).
       01 FS-RECDATA                   PICTURE X(02).                   
    
      * ------- Counters
       01 WRK-COUNTER                  PICTURE 9(03) USAGE COMP.
       01 WRK-VALID                    PICTURE 9(03) USAGE COMP.
       01 WRK-UNALID                   PICTURE 9(03) USAGE COMP.


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
           DISPLAY "---------------------------------------------".

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

       0400-OUTPUT-PROCEDURE  SECTION. 
           CLOSE CLIENTDAT. 
           CLOSE RECDATA.                    
           DISPLAY "CLIENTS READ: " WRK-COUNTER.
           DISPLAY "VALIDS: " WRK-VALID.                              
           DISPLAY "UNVALIDS: " WRK-UNALID.                                         
           DISPLAY "CLOSING PROCEDURE, GOODBYE".
       0400-END.               EXIT.
