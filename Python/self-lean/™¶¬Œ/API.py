import pymysql
from flask import Flask,jsonify
from flask_sqlalchemy import  SQLAlchemy
from flask import request
import json
print(123)
app = Flask(__name__)
db = pymysql.connect(host = '192.168.1.88',port = 3306,password = '05128',user = 'Alvin',
                    database = 'club')
cursor = db.cursor()
@app.route('/')
def index():
    return "<p>Hello World!</p>"

@app.route('/clubName',methods = ['POST'])
def clubName():
    #data = request.json['club_classification']
    #print(type(data))
    test = '學藝性社團'
    sql = "SELECT clubs_name FROM clubs WHERE clubs_classification LIKE  '%s' " % test
    try:
        cursor.execute(sql)
        results = cursor.fetchall()
    except:
        print('QAQ')
    print(results)
    club_name = list(results)
    data = {}
    for name in club_name:
        data[name] = cursor.execute("SELECT clubs_OfficalWebsiteUrl FROM clubs WHERE club_name LIKE  '%s' " % name)
    return jsonify(data)
    
if __name__ == '__main__':
    app.run(debug=True)