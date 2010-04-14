Date: Wed, 14 Apr 2010 17:28:59 +0800 (CST)
From: =?gbk?B?1cXM7NSw?= <mariazty@163.com>
Message-ID: <1a24892.16fba.127fba66ac2.Coremail.mariazty@163.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_245085_18682180.1271237339841"
Subject: [Bridge] problems using bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

------=_Part_245085_18682180.1271237339841
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

Hi,
        I use the bridge these days but I come up with some problems when I use it.
        I add two wifi interfaces to the bridge I call it "br0" . What I do is as follows :
 #brctl addbr br0
#brctl addif br0 eth0
#brctl addif br0 eth1
#ifconfig eth0 0.0.0.0
#ifconfig eth1 0.0.0.0
#ifconfig br0 up
#dhclient br0
       The AP gives br0 the address 172.31.24.68 and the gateway is 172.31.24.1 (this detailed address maybe not important though)
      I use the command ifconfig and find that the br0's mac is the same as eth1's . When both the two wifi interfaces are up ,there's no problem when PING the gateway . But when I ifconfig eth1 down , PING the gateway again ,it shows destination host unreachable . But when I ifconfig eth0 down , it doesn't affect PING the gateway . I think this may because br0 is bound to eth1 , the traffic pass through eth1 . 
      Now here comes the problem . I want br0 bound to eth0 ,what should I do ?
     I'm looking forward to your answer and I'm eager to know it. Thank you very much .
------=_Part_245085_18682180.1271237339841
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: 7bit

<DIV>Hi,</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I use the bridge these days but I come up with some problems when I use it.</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I add two wifi interfaces to the bridge I call it "br0" . What I do is as follows :</DIV>
<DIV>&nbsp;#brctl addbr br0</DIV>
<DIV>#brctl addif br0 eth0</DIV>
<DIV>
<DIV>#brctl addif br0 eth1</DIV>
<DIV>#ifconfig eth0 0.0.0.0</DIV>
<DIV>
<DIV>#ifconfig eth1 0.0.0.0</DIV>
<DIV>
<DIV>#ifconfig br0 up</DIV>
<DIV>#dhclient br0</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The AP gives br0 the address 172.31.24.68 and the gateway is 172.31.24.1 (this detailed address maybe not important though)</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I use the command ifconfig and find that the br0's mac is the same as eth1's . When both the two wifi interfaces are up ,there's no problem when PING the gateway . But when I ifconfig eth1 down , PING the gateway again ,it shows destination host unreachable . But when I ifconfig eth0 down , it doesn't affect PING the gateway . I think this may because&nbsp;br0 is bound to eth1 , the traffic pass through eth1 . </DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Now&nbsp;here comes&nbsp;the problem . I want br0 bound to eth0 ,what should I do ?</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; I'm looking forward to your answer and I'm eager to know it. Thank you very much .</DIV></DIV></DIV></DIV><br><br><span title="neteasefooter"/></span>
------=_Part_245085_18682180.1271237339841--

