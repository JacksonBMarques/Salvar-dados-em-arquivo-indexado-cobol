      ******************************************************************
      * Author: Breno Marques
      * Date: 25/01/2024
      * Purpose: cadastrar alunos e salvar num arquivo
      * Tectonics: cobc Linguagem: COBOL
      * Complexidade: C
      *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CADALUN.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
                DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
            FILE-CONTROL.
                SELECT ALUNO ASSIGN TO
                'D:\Curso 1 COBOL\Desafio modulo 3\CFP001S1.DAT'
                ORGANISATION IS INDEXED
                ACCESS  MODE IS RANDOM
                RECORD KEY IS ID-ALUNO
                FILE STATUS IS WS-FILES.

       DATA DIVISION.
       FILE SECTION.
       FD ALUNO.
          COPY CFPK0001.
       WORKING-STORAGE SECTION.
       01 WS-ALUNO                    PIC X(32) VALUE SPACES.
       01 FILLER REDEFINES WS-ALUNO.
          03 WS-ID-ALUNO              PIC 9(03).
          03 WS-NM-ALUNO              PIC X(20).
          03 WS-TL-ALUNO              PIC 9(09).
       77 WS-FILES                    PIC 99.
          88 FILES-OK                 VALUE 0.
       77 WS-EXIT                     PIC X.
          88 EXIT-OK                  VALUE 'F' FALSE 'N'.


       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

            DISPLAY '*** Cadastro de Alunos'

            SET EXIT-OK                   TO FALSE

            PERFORM P1-CADASTRA           THRU P1-FIM UNTIL EXIT-OK
            PERFORM P0-FIM
            .

       P1-CADASTRA.
            SET FILES-OK                      TO TRUE

            DISPLAY 'PARA REGISTRAR UM ALUNO, INFORME: '
            DISPLAY 'Um numero para identificacao: '
            ACCEPT WS-ID-ALUNO
            DISPLAY 'Um nome para o aluno: '
            ACCEPT WS-NM-ALUNO
            DISPLAY 'Um telefone para o aluno: '
            ACCEPT WS-TL-ALUNO

            OPEN I-O ALUNO

            IF WS-FILES EQUAL 35 THEN
                OPEN OUTPUT ALUNO
            END-IF

            IF FILES-OK THEN
                     MOVE WS-ID-ALUNO          TO ID-ALUNO
                     MOVE WS-NM-ALUNO          TO NM-ALUNO
                     MOVE WS-TL-ALUNO          TO TL-ALUNO

                              WRITE REG-ALUNO
                           INVALID KEY
                              DISPLAY 'ALUNO JÁ CADASTRADO!'
                           NOT INVALID KEY
                              DISPLAY 'Contato cadastrado com sucesso!'
                     END-WRITE
            ELSE
                DISPLAY 'ERRO AO ABRIR O ARQUIVO DE ALUNOS'
                DISPLAY 'FILE STATUS: ' WS-FILES
            END-IF

            CLOSE ALUNO

            DISPLAY
              'TECLE: '
              '<QUALQUER TECLA> para continuar ou <F> para finalizar.'
              ACCEPT WS-EXIT
              IF WS-EXIT = 'f'
                       MOVE 'F'       TO WS-EXIT
              END-IF
            .
       P1-FIM.

       P0-FIM.
            STOP RUN.
       END PROGRAM CADALUN.
