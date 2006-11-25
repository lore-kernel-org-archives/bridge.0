Message-ID: <20061125074439.45592.qmail@web54210.mail.yahoo.com>
Date: Fri, 24 Nov 2006 23:44:39 -0800 (PST)
From: kasra kangavari <kasra_kng@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-405759832-1164440679=:45227"
Subject: [Bridge] Passing vlan tagged packets through linux bridge
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

--0-405759832-1164440679=:45227
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi
 
 I have some problem with passing vlan tagged packets through linux bridge.
 In the linux box eth0 , eth1  are add to br0 and the bridge is up and working correctly. 
 I 've connected eth0 to trunk port of switch A and eth1 to trunk port of switch B.
 port 1,2,3 of each switch are in vlan 1. I've 2 client in the same subnet , client A connected to port 1 of switch A and client B connected to port 1 of switch . the problem is when I ping client A from clinet B or viceversa ,I can't ping with more than 1470bytes packet size!
 ping will work fine by 1470byte packet size but ping with more than 1470bytes packet size will fail.
 any idea??
 
 KasrA
 
 
---------------------------------
Check out the all-new Yahoo! Mail beta - Fire up a more powerful email and get things done faster.
--0-405759832-1164440679=:45227
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi<br> <br> I have some problem with passing vlan tagged packets through linux bridge.<br> In the linux box eth0 , eth1&nbsp; are add to br0 and the bridge is up and working correctly. <br> I 've connected eth0 to trunk port of switch A and eth1 to trunk port of switch B.<br> port 1,2,3 of each switch are in vlan 1. I've 2 client in the same subnet , client A connected to port 1 of switch A and client B connected to port 1 of switch . <span DEFANGED_style="font-weight: bold;">the problem is</span> when I ping client A from clinet B or viceversa ,I can't ping with more than 1470bytes packet size!<br> ping will work fine by 1470byte packet size but ping with more than 1470bytes packet size will fail.<br> any idea??<br> <br> KasrA<br> <p>&#32;

<hr size=1>Check out <a href="http://us.rd.yahoo.com/evt=43257/*http://advision.webevents.yahoo.com/mailbeta">the all-new Yahoo! Mail beta</a> - Fire up a more powerful email and get things done faster.
--0-405759832-1164440679=:45227--
