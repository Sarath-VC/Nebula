from flask import Flask,render_template,request,flash
from Nebula import Nebula
import demjson
app = Flask(__name__)
app.secret_key = "ASDSDSDFSGFHGKJGFDRSEFBGFd"
nb = Nebula()

@app.route('/')
def nebula_admin():
	return render_template('nebula_admin.html')

@app.route('/register_db',methods=['get','post'])
def register_db():
	db_dir = "dump/"
	if "upload" in request.form:
		file = request.files['sqldump']
		filename = file.filename
		file.save(db_dir + filename)

	return render_template('register_db.html')

@app.route('/register_sub_server/',methods=['get','post'])
def register_sub_server():
	if "register" in request.form:
		host = request.form['host']
		username = request.form['username']
		password = request.form['password']
		if(nb.register_sub_server(host,username,password)) : 
			print "Success"
			flash("Success")
		else:
			print "Failed"
			flash("Failed")
	return render_template('register_sub_server.html')

@app.route('/start_nebula_thread/',methods=['get','post'])
def start_nebula_thread():
	try:
		nb.start_nebula()
		return "success"
	except Exception,e:
		return "Failed"
	

@app.route('/stop_nebula_thread/',methods=['get','post'])
def stop_nebula_thread():
	nb.stop_nebula()
	return "success"

@app.route('/get_database_status/',methods=['get','post'])
def get_database_status():
    re=nb.get_database_status()
    return demjson.encode(re)

app.run(debug=True,threaded=True)
