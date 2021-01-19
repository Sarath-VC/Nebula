import mysql.connector

class DB:
    con = True
    def __init__(self,config):
        try:
            self.cnx = mysql.connector.connect(**config)
            self.cur = self.cnx.cursor(dictionary=True)
        except Exception,e:
            self.con = False
        print "Connection Status for " + config['host'] + " : " + str(self.con)
    def __del__(self):
        self.cnx.close()
        self.cur.close()
    def connection_status(self):
        return self.con

    def create_db(self,db_name):
        q = "DROP DATABASE IF EXISTS %s"% (db_name)
        self.cur.execute(q)
        q= "CREATE DATABASE %s;" % (db_name)
        self.cur.execute(q)
        self.cnx.commit()
    def upload_sql(self,path):
        file = open(path, 'r')
        # sql = " ".join(file.readlines())
        q = ""
        for line in file:
            line = line.strip()
            if line!="" and not line.startswith("--"):
                q += " " + line
                if  q.endswith(";"):
                    self.cur.execute(q)  
                    q = ""  
        self.cnx.commit()
    


    def select(self, q):
        self.cur.execute(q)
        return self.cur.fetchall()

    def insert(self, q):
        self.cur.execute(q)
        self.cnx.commit()
        return self.cur.lastrowid

    def update(self, q):
        self.cur.execute(q)
        self.cnx.commit()
        return self.cur.rowcount

    def delete(self, q):
        self.cur.execute(q)
        self.cnx.commit()
        return self.cur.rowcount
    def query(self, q):
        self.cur.execute(q)
        self.cnx.commit()


