import re
from Database import DB 

class Transfer:
	def __init__(self,from_conf,to_conf,db_sql_path):
		self.from_db = DB(from_conf)
		self.to_db = DB(to_conf)
		self.sql_array = []

		sql_file = open(db_sql_path,'r')
		
		q = ""
		for line in sql_file:
			line = line.strip()
			if line!="" and not line.startswith("--"):
				q += " " + line
				if  q.endswith(";"):
					self.sql_array.append(q);
					q = ""  

	def from_db_tables(self):
		q = "show tables"
		return self.from_db.select(q)
	def create_db_to_db(self,database):
		q = "DROP DATABASE IF EXISTS `%s`" % database
		self.to_db.query(q)
		q = "CREATE DATABASE %s" % database
		self.to_db.query(q)
		self.use_db_to_db(database)
	def use_db_to_db(self,database):
		q = "use %s" % database
		self.to_db.query(q)
	def drop_to_db(self,table_name):
		q = "DROP TABLE IF EXISTS `%s`" % table_name
		self.to_db.query(q)

	def create_table_to_db(self,database,table_name):
		create_q = ""
		alter_q = ""
		primary_q = ""
		for q in self.sql_array:
			search = "CREATE TABLE `%s`" % table_name
		 	if q.find(search) > -1:
			 		create_q = q
			 		break
		for q in self.sql_array:
			alter = "ALTER TABLE `%s`" % table_name
			if q.find(alter) > -1:
		 		if q.find(table_name) > -1:
		 			if q.find("PRIMARY KEY") > -1:
			 			primary_q = q
			 			break;
		for q in self.sql_array:
			alter = "ALTER TABLE `%s`" % table_name
			if q.find(alter) > -1:
		 		if q.find(table_name) > -1:
		 			if q.find("AUTO_INCREMENT") > -1:
			 			alter_q = q
			 			break;

		auto_inc = "SELECT `AUTO_INCREMENT` FROM  INFORMATION_SCHEMA.TABLES	WHERE TABLE_SCHEMA = '"+database+"'	AND   TABLE_NAME   = '"+table_name+"'"

		auto_inc_val = self.from_db.select(auto_inc)[0]['AUTO_INCREMENT']

		alter_q = re.sub('[AUTO_INCREMENT=]{15}[0-9]{0,10}', "AUTO_INCREMENT=%s"%auto_inc_val, alter_q)
			 		
		# print create_q
		# print primary_q
		# print alter_q
		self.to_db.query(create_q)
		self.to_db.query(primary_q)
		self.to_db.query(alter_q)

	def copy_table_data(self,table_name):
		q = "select * from %s" % table_name
		result = self.from_db.select(q)
		for row in result:
			values = []
			for key in row.keys():
				values.append(str(row[key]))
			values = "','".join(values)

			# q = "insert into " + str(table_name) + " " +  str(tuple(row.keys())).replace("'","`").replace("u`","`") + "values" + str(tuple(row.values())).replace("u'","'")
			q = "insert into " + str(table_name) + " " + str(tuple(row.keys())).replace("'","`").replace("u`","`") + " " + "values ('" + values + "')"
			# print q
			self.to_db.insert(q)
	def drop_db_from_db(self,database):
		q = "drop database  %s" % database
		self.from_db.query(q)

	def transfer(self,database):

		self.create_db_to_db(database)
		result = self.from_db_tables()
		for table in result:
			table_name = table['Tables_in_' + database]
			self.drop_to_db(table_name)
			self.create_table_to_db(database,table_name)
			self.copy_table_data(table_name)
		self.drop_db_from_db(database)




# from_conf = {
# 	"host":"192.168.1.11",
# 	"user":"root",
# 	"password":"root",
# 	"database":"finger_print_lock_system"
# }

# to_conf = {
# 	"host":"192.168.1.11",
# 	"user":"root",
# 	"password":"root"
# }

# tf = Transfer(from_conf,to_conf,"structure/finger_print_lock_system.sql")
# tf.transfer('finger_print_lock_system')

