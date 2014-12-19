class A {
	int r1234;
	 float m_altitude;
	 float m_latitude;
	 string m_name;

	function float getA(int i) { }
	function int getA() { }
	function bool getA(float i, char j) { }
	function char getA(int i, bool b) { }

	function int getA(int i,string s) {	
	  int a;
	  bool z;
	  char c;
	  float f;
	  a = 0;
	  z = false;
	  m_altitude = 0.987;
	  m_latitude = 40.08;
	  m_name = "test";

	  a = 0.0;
	  z = "false";
	  m_altitude = 987;
	  m_latitude = 'a';
	  m_name = 'n';
	  c = "c";

	  z = true || 1;
	  m_altitude = c * a;
	  m_altitude = z + m_altitude + "asd" * 'f';
	  m_altitude = m_altitude + m_latitude - 1.0123 + 0.0123;

	  qq = a;
	  qa = qe && !qr;
	  z = !z;
	  z = 123 / asd;

	  a = getA();
	  z = getA(f, c);
	  c = 'c' + getA(i, s, j);
	  a = 123 + getA(i, s);

	  if (i == 0.0) {
	  	m_altitude = 0.123;
	  	m_latitude = 0.321;
	  } elseif (i >= 1) {
	  	m_altitude = 0.321;
	  	m_latitude = 0.123;
	  } elseif (i != 2) {
	  	m_altitude = 0.456;
	  	m_latitude = 0.654;
	  } elseif (z) {
	  	m_altitude = 0.456;
	  } elseif (!!!z) {
	  	m_altitude = 0.456;
	  } else {
	  	m_altitude = 0.654;
	  	m_latitude = 0.456;
	  }
	}
}