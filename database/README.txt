# Creating new user
1. login to db as root (passwd=root):
	sudo mysql -u root -p
2. Create user:
	CREATE USER 'username'@'localhost' IDENTIFIED BY 'userpasswd'; 
3. Define privileges for user:
	GRANT ALL PRIVILEGES ON 'hol9000db'.* TO 'username'@'localhost';


# Executing SQL script
1. login to db:
	sudo mysql -u root -p hol9000db
2. run .sql script:
	source /path_to_sql_file/