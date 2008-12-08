Message-ID: <13ab752e0812080532g1e42917al40e5e836418f570d@mail.gmail.com>
Date: Mon, 8 Dec 2008 21:32:04 +0800
From: "=?GB2312?B?sszBosj9?=" <cailisan1985@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_63852_5514816.1228743124474"
Subject: [Bridge] Hello, I meet a problem, I help you can give me some advice
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

------=_Part_63852_5514816.1228743124474
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear sir:

I have met a problem.
The situation is that, I port bridge-utils to a Embedded linux system.
It works well.
I can use brctl command to add a bridge.
And I implement the blow command.

./brctl addbr br0
./brctl stp br0 off
./brctl addif br0 eth0
./brctl addif br0 wlan0
ifconfig eth0 down
ifconfig wlan0 down
ifconfig eth0 0.0.0.0 up
ifconfig wlan0 0.0.0.0 up
ifconfig br0 192.168.1.3 netmask 255.255.255.0
 echo "1" > /proc/sys/net/ipv4/ip_forward
cat /proc/sys/net/ipv4/ip_forward
route add default gw 192.168.1.1
route

The command execute correctly.
But I cannot ping through it.
I can just ping from the wireless terminal to br0 and ping from the wired
terminal to br0.
The wireless terminal cannot ping to wired terminal through br0.
the version of linux system is 2.6.8.1 and the version of the bridge-utils
is 1.0.6

I hope you can give me some advice.
Thank you.

sincerely

Cai Lisan

------=_Part_63852_5514816.1228743124474
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear sir:<br><br>I have met a problem.<br>The situation is that, I port bridge-utils to a Embedded linux system.<br>It works well.<br>I can use brctl command to add a bridge.<br>And I implement the blow command.<br><br>./brctl addbr br0 <br>
./brctl stp br0 off <br>./brctl addif br0 eth0 <br>./brctl addif br0 wlan0 <br>ifconfig eth0 down <br>ifconfig wlan0 down <br>ifconfig eth0 <a href="http://0.0.0.0">0.0.0.0</a> up <br>ifconfig wlan0 <a href="http://0.0.0.0">0.0.0.0</a> up <br>
ifconfig br0 <a href="http://192.168.1.3">192.168.1.3</a> netmask <a href="http://255.255.255.0">255.255.255.0</a> <br>&nbsp;echo &quot;1&quot; &gt; /proc/sys/net/ipv4/ip_forward <br>cat /proc/sys/net/ipv4/ip_forward <br>route add default gw <a href="http://192.168.1.1">192.168.1.1</a> <br>
route <br><br>The command execute correctly.<br>But I cannot ping through it.<br>I can just ping from the wireless terminal to br0 and ping from the wired terminal to br0.<br>The wireless terminal cannot ping to wired terminal through br0.<br>
the version of linux system is <a href="http://2.6.8.1">2.6.8.1</a> and the version of the bridge-utils is 1.0.6<br><br>I hope you can give me some advice.<br>Thank you.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sincerely<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cai Lisan<br><br>

------=_Part_63852_5514816.1228743124474--
