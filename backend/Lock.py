from time
import datetime
import sys
from mfrc5222 import SimpleMFRC522
import mysql.connector as MySQLConn
import RPi.GPIO as GPIO

class Lock:
    def __init__(self, room_num):
        self.room_num = room_num
        self.rfid_reader = SimpleMFRC522()
        self.db_connection = MySQLConn.connect(
            host="localhost",
            user="smartlock1",
            password="lock1",
            database="hol9000db"
        )
        self.db_conn = self.db_connection.cursor()
        self.currently_inside_list = []      # list of people currently inside the room
        self.locked = True
        self.db_conn.execute(f"SELECT idPomieszczenia FROM Pomieszczenia\
                             WHERE numerPomieszczenia={self.room_num}")
        rid = self.db_conn.fetchall()
        self.room_id = rid[0][0] # download and save room id at the start
        print(f'Room number={self.room_num}, room id={self.room_id}')   # --------------------- DEBUG
        self.setup_GPIO(20, 31, 33)     # BOARD pin indexing

    # activates lock and starts its mainloop
    def activate(self):
        try:
            while True:
                print("Place rfid card")            #----------- DEBUG
                id, data = self.rfid_reader.read()
                card_id = data.replace(" ", "")
                if self._is_accessible(card_id):        # if user can access this room
                    if not self.locked:                 # if the room is unlocked
                        if self._was_scanned(card_id):  # if the user had already accessed this room (wants to lock it now)
                            self.currently_inside_list.remove(card_id)
                            if len(self.currently_inside_list) == 0:    # last person left the room and wants to lock it
                                self._lock_room()
                                self._left_room(card_id)
                        else:                       # user havent already scanned his card
                            self.light_blue()   # room is already opened
                            self.currently_inside_list.append(card_id)
                            self._entered_room(card_id)
                    else:                           # if the room is locked
                        self._unlock_room()
                        self.currently_inside_list.append(card_id)
                        self._entered_room(card_id)
                else:                               # if user does not have the right to access the room
                    self.light_red()
                    print("You lack priviledges to access this room")

                time.sleep(2)
                self.turn_off_LED()
        except KeyboardInterrupt:
            GPIO.cleanup()
            raise

    # method for checking in database if user can access this room
    def _is_accessible(self, card_id):
        print(f"SELECT idPracownik FROM Pracownik\
                             WHERE AccessCardID={card_id}")         #---------------- DEBUG

        self.db_conn.execute(f"SELECT idPracownik FROM Pracownik\
                             WHERE AccessCardID={card_id}")
        ret = self.db_conn.fetchall()

        print(f'user id={ret}')     # ---------------------------- DEBUG

        user_id = ret[0][0]

        print(f"SELECT COUNT(1) FROM Pracownik_ma_dostep_do_Pomieszczenia\
        WHERE Pomieszczenia_idPomieszczenia={self.room_id} AND Pracownik_idPracownik={user_id}"     #----------- DEBUG

        self.db_conn.execute(f"SELECT COUNT(1) FROM Pracownik_ma_dostep_do_Pomieszczenia\
        WHERE Pomieszczenia_idPomieszczenia={self.room_id} AND Pracownik_idPracownik={user_id}")
        result = self.db_conn.fetchall()

        print(f'accessible={result}')  #------------------- DEBUG

        return result[0][0] == 1

    # checks if user already scanned the card (if scanned then the second scan means that he wants to close the room)
    def _was_scanned(self, card_id):
        return card_id in self.currently_inside_list
    
    # locks the room with electromagnetic lock
    def _lock_room(self):
        self.light_green()  # closed successfully
        self.locked = True
    
    # unlocks the room with electromagnetic lock
    def _unlock_room(self):
        self.light_green()  # successfully opened
        self.locked = False

    # notifies databse that user entered the room
    def _entered_room(self, card_id):
        ts = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')

        print(f"SELECT idPracownik FROM Pracownik\
                             WHERE AccessCardID={card_id}")     # --------- DEBUG

        self.db_conn.execute(f"SELECT idPracownik FROM Pracownik\
                             WHERE AccessCardID={card_id}")
        ret = self.db_conn.fetchall()
        
        print(f'user id={ret}')     #------------------ DEBUG
        
        user_id = ret[0][0]

        print(f"INSERT INTO Pracownik_odwiedzil_Pomieszczenia \
        (Pracownik_idPracownik, Pomieszczenia_idPomieszczenia, kiedyUzylTuKarty)\
        VALUES ({user_id}, {self.room_id}, {ts})")                                      #---------------- DEBUG

        self.db_conn.execute(f"INSERT INTO Pracownik_odwiedzil_Pomieszczenia \
        (Pracownik_idPracownik, Pomieszczenia_idPomieszczenia, kiedyUzylTuKarty)\
        VALUES ({user_id}, {self.room_id}, '{ts}')")
        self.db_connection.commit()     # commit data to database (data will be written)

        print("timestamp inserted")     #------------- DEBUG

    # GPIO pin setup for RGB LED
    def setup_GPIO(self, redPin, greenPin, bluePin):
        GPIO.setmode(GPIO.BOARD)
        self.red_pin = redPin
        self.green_pin = greenPin
        self.blue_pin = bluePin
        GPIO.setup(self.red_pin, GPIO.OUT)
        GPIO.setup(self.green_pin, GPIO.OUT)
        GPIO.setup(self.blue_pin, GPIO.OUT)

    # light LED in red - error
    def light_red(self):
        GPIO.output(self.red_pin, GPIO.HIGH)
        GPIO.output(self.green_pin, GPIO.LOW)
        GPIO.output(self.blue_pin, GPIO.LOW)

    # light LED in blue - already opened && scanned successfully
    def light_blue(self):
        GPIO.output(self.red_pin, GPIO.LOW)
        GPIO.output(self.green_pin, GPIO.LOW)
        GPIO.output(self.blue_pin, GPIO.HIGH)

    # light LED in green - opened/locked
    def light_green(self):
        GPIO.output(self.red_pin, GPIO.LOW)
        GPIO.output(self.green_pin, GPIO.HIGH)
        GPIO.output(self.blue_pin, GPIO.LOW)

    # turns the LED off
    def turn_off_LED(self):
        GPIO.output(self.red_pin, GPIO.LOW)
        GPIO.output(self.green_pin, GPIO.LOW)
        GPIO.output(self.blue_pin, GPIO.LOW)
        