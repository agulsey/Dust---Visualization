public class Data {
  FlowField flowfield;
  ParticleSystem ps;
  Table table;
  String name;
  float particleSize;
  int flow;
  Data (Table _table, String _name, float _particleSize, int _flow) {
    table = _table;
    name = _name;
    particleSize = _particleSize;
    flow = _flow;
    init();
  }
  
  void init () { 
    flowfield = new FlowField(flow);
    flowfield.update();
    ps = new ParticleSystem(flowfield, particleSize);
    for (int i = 0; i < maxValue; i++) {
      ps.addParticle();
    }
    
  }
  void run () {
    flowfield.update();
    ps.run();
  }
  
  void updateValue (int date) {
    TableRow row = table.getRow(date);
    int val = row.getInt(name);
    val = int(map(val, 0, getMaxValue(), 0, maxValue));
    ps.showParticles(val); 
  }
  
  float getMaxValue () {
    float tableMax = 0;
    for (int i=0; i<table.getRowCount(); i++) {
      TableRow row = table.getRow(i);
      tableMax = max(tableMax, row.getInt(name));
    }
    println(name + " tableMax " + tableMax);
    return tableMax;
  }
}
