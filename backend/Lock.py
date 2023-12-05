from time import sleep
import sys
from mfrc5222 import SimpleMFRC522
import mysql.connector as MySQLConn

class Lock:
    def __init__(self, room_number, access_level):
        self.room_num = room_number 
        self.access_lvl = access_level
        self.rfid_reader = SimpleMFRC522()
        self.db_conn = MySQLConn.connect(
            host="localhost",
            user="smartlock1",
            password="lock1",
            database="hol9000db"
        )
        self.currently_inside_list = []      # list of people currently inside the room
        self.locked = True

    def activate(self):
        try:
            while True:
                id, data = self.rfid_reader.read()
                user_id = data
                if self._is_accessible(user_id):        # if user can access this room
                    if not self.locked:                 # if the room is unlocked
                        if self._was_scanned(user_id):  # if the user had already accessed this room (wants to lock it now)
                            self.currently_inside_list.remove(user_id)
                            if len(self.currently_inside_list) == 0:    # last person left the room and wants to lock it
                                self._lock_room()
                                self._left_room(user_id)
                        else:                       # user havent already scanned his card
                            self.currently_inside_list.append(user_id)
                            self._entered_room(user_id)
                    else:                           # if the room is locked
                        self._unlock_room()
                        self.currently_inside_list.append(user_id)
                        self._entered_room(user_id)
                else:                               # if user does not have the right to access the room
                    print("You lack priviledges to access this room")
                sleep(1)
        except KeyboardInterrupt:
            GPIO.cleanup()
            raise

    # method for checking in database if user can access this room
    def _is_accessible(self, user_id):
        pass

    # checks if user already scanned the card (if scanned then the second scan means that he wants to close the room)
    def _was_scanned(self, user_id):
        return user_id in self.currently_inside_list
    
    # locks the room with electromagnetic lock
    def _lock_room(self):
        self.locked = True
    
    # unlocks the room with electromagnetic lock
    def _unlock_room(self):
        self.locked = False

    # notifies databse that user entered the room
    def _entered_room(self, user_id):
        pass

    # notifies database that user left the room
    def _left_room(self, user_id):
        pass