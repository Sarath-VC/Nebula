import os
import socket
import shutil
import mysql.connector
import time
import thread
from Database import DB
from Transfer import Transfer
class Nebula:
	def __init__(self):

		self.DUMP_DIR = "dump"
		self.STRUCTURE_DIR = "structure"
		self.DIR_SEP = "/"
		self.NEBULA = False

		hostname = socket.gethostname()   
		ip_addr = socket.gethostbyname(hostname)
		
		self.config = {
			"host" : ip_addr,
			"user": "root",
			"password":"root"
		}
		self.server_sql = DB(self.config)

		nebula_config = self.config
		nebula_config['database'] = "nebula"

		self.nebula_sql = DB(nebula_config)

		self.update_main_ip(ip_addr)

	def update_main_ip(self,host):
		q = "select * from cloud where type='%s'" % 'main' 
		if(len(self.nebula_sql.select(q)) > 0):
			q = "update cloud set host='%s' where type='main'" % host
			self.nebula_sql.update(q)
		else:
			q = "insert into cloud(host,username,password,type)values('%s','%s','%s','%s')" % (host,self.config['user'],self.config['password'],'main')
			print q
			self.nebula_sql.insert(q)

	def register_sub_server(self,host,username,password):
		config = {
			"host" : host,
			"user": username,
			"password":password
		}
		db = DB(config)
		if db.connection_status():
			q = "insert into cloud (host,username,password,type)values('%s','%s','%s','%s')" % (host,username,password,"sub")
			self.nebula_sql.insert(q)
			return True
		else:
			return False

	def initialize_dump(self):
		# self.stop_thread()
		for dbname in os.listdir(self.DUMP_DIR):
			if dbname.endswith('.sql'):

				dbname = dbname.replace(".sql","")
				self.server_sql.create_db(dbname)


				db_config = self.config
				db_config['database'] = dbname
				db = DB(db_config)

				db.upload_sql(self.DUMP_DIR + self.DIR_SEP + dbname + ".sql")

				shutil.move(self.DUMP_DIR + self.DIR_SEP + dbname + ".sql",self.STRUCTURE_DIR + self.DIR_SEP)

				del(db)

			q = "select * from db where db_name='%s'" % dbname
			result = self.nebula_sql.select(q)
			if(len(result) == 0 ):
				q = "insert into db (db_name) values('%s')" % dbname
				id = self.nebula_sql.insert(q)
			else:
				id = result[0]['db_id']
			q = "INSERT INTO `log`( `cloud_id`, `db_id`) SELECT cloud_id,'%s' from cloud WHERE type = 'main'" % id
			self.nebula_sql.insert(q)
			# self.log()

	def get_config(self,row):
		if "db_name" in row:
			config = {
				"host":row['host'],
				"user":row['username'],
				"password":row['password'],
				"database":row['db_name'],
			}
		else:
			config = {
				"host":row['host'],
				"user":row['username'],
				"password":row['password'],
			}
		return config

	def log(self,cloud_id,db_id):
		q= "insert into log (cloud_id,db_id) values('%s','%s')" %(cloud_id,db_id)
		self.nebula_sql.insert(q)

	def random_host(self,cloud_id):
		q = "SELECT * FROM cloud where cloud_id <> '%s' ORDER BY RAND()  LIMIT 1;" % cloud_id
		result = self.nebula_sql.select(q)
		db= DB(self.get_config(result[0]))
		if(db.connection_status):
			return result[0]
		else :
			print "Connection to %s failed" % result[0]['host']
			return False

	def get_last_host(self,db_id):
		q = "select * from log inner join cloud using(cloud_id) inner join db using(db_id) where db_id='%s' order by log_id DESC LIMIT 1" % db_id
		return self.nebula_sql.select(q)[0]
	# def make_busy(self,database):
	# 	q = "update db set db_status = 'busy' where db_name='database' "
	# 	self.nebula_sql.query(q)
	# def make_available(self,database):
	# 	q = "update db set db_status = 'available' where db_name='database' "
	# 	self.nebula_sql.query(q)
	def nebula_thread(self,name,delay):
		while(True):
			if self.NEBULA:
				time.sleep(delay)
				self.initialize_dump()
				q = "select * from db"
				result = self.nebula_sql.select(q)
				for row in result:
					last_host = self.get_last_host(row['db_id'])
					print last_host
					if last_host:
						new_host = self.random_host(last_host['cloud_id'])
						tf = Transfer(self.get_config(last_host),self.get_config(new_host),self.STRUCTURE_DIR + self.DIR_SEP + row['db_name'] + ".sql")
						# self.make_busy(row['db_name'])
						tf.transfer(row['db_name'])
						self.log(new_host['cloud_id'],row['db_id'])
						# self.make_available(row['db_name'])
				# print time.ctime(time.time())
			else:
				break
		return


	def start_nebula(self):
		self.NEBULA = True
		try:
			thread.start_new_thread( self.nebula_thread,("Nebula",300) )
		except Exception,e:
			pass
	def stop_nebula(self):
		self.NEBULA = False

	def get_database_status(self):
		q = "select * from db"
		databases = self.nebula_sql.select(q)
		result = []
		for row in databases:
			q="select * from log inner join db using(db_id) inner join cloud using (cloud_id) where db_id='%s' order by log_id DESC LIMIT 1" %(row['db_id'])
			row = self.nebula_sql.select(q)[0]
			result.append(row)
		return result

