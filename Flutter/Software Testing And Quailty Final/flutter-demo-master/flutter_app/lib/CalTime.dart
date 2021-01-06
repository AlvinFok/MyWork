class CalTime{
  var Chours=0.0,Csalary=0.0;
  FTServer server;

  void setSalary(double salary){
    this.Csalary = salary;
  }

  void setServer(FTServer s){
    this.server = s;
  }

  double calHr(DateTime StartDate,DateTime EndDate){
    Duration difference = EndDate.difference(StartDate);
    var hr = difference.inMinutes/60;
    if(hr<0){
      print("hr:$hr < 0");
      hr = 0.0;
    }
    //Chours = Chours + hr;
    //print("Class hours:$Chours");
    return format(hr);
  }

  double calPTSalary(double hr,double salary){
    int h = 0;
    if(hr%1 < 0.5){
      h = (hr/1).toInt();
    }
    else{
      h = (hr/1+1).toInt();
    }
    var op = h*salary;
    //var temp = Chours * Csalary;
    //print("Class salary:$temp");
    return op;
  }

  double calFTSalary(DateTime StartDate){
    double salary = server.setFTSalary();
    if(StartDate.day>=15 && StartDate.day<=31){
      return salary;
    }else{
      return 0;
    }

  }

  double format(double hr){
    String t = hr.toStringAsFixed(hr.truncateToDouble() == hr ? 0 : 2);
    return double.parse(t);
  }

}

class FTServer{
  double setFTSalary(){
    return 1;
  }
}