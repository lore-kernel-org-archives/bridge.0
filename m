From: "herwam herwam" <dedmoroz3000@hotmail.com>
Date: Thu, 29 Apr 2004 17:20:29 +0200
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1083252035-11007-828"
Message-ID: <BAY16-F92EuW6qVKUyg000109ae@hotmail.com>
Subject: [Bridge] FW: [Openvpn-users] linux bridge is bad
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

This is a multi-part message in MIME format...

------------=_1083252035-11007-828
Content-Type: text/html; charset=iso-8859-1
Content-Disposition: inline

<html><div DEFANGED_style="background-color:"><P><BR><BR></P>
<DIV>
<DIV class=RTE>&nbsp;</DIV>
<DIV></DIV>Hi All, 
<DIV></DIV>I am using a bridge with openvpn .Linux Server&nbsp;with dhcp and a debian client&nbsp;.With Windows Client evrything looks great i have 2 Ip opne 
<DIV></DIV>public from provider other private from dhcp one from vpn. 
<DIV></DIV>With Linux Client i have problem with this setup: up.sh 
<DIV></DIV>&gt; 
<DIV></DIV>&gt;#!/bin/sh 
<DIV></DIV>&gt;/sbin/modprobe tun 
<DIV></DIV>&gt;/sbin/modprobe bridge 
<DIV></DIV>&gt;ifconfig eth0 down 
<DIV></DIV>&gt;/usr/sbin/openvpn --mktun --dev tap0 
<DIV></DIV>&gt;/usr/sbin/brctl addbr br0 
<DIV></DIV>&gt;/usr/sbin/brctl addif br0 tap0 
<DIV></DIV>&gt;/usr/sbin/brctl addif br0 eth0 
<DIV></DIV>&gt;/sbin/ifconfig tap0 0.0.0.0 promisc up 
<DIV></DIV>&gt;/sbin/ifconfig eth0 0.0.0.0 promisc up 
<DIV></DIV>&gt;ifconfig br0 xxx.xxx.xxx.240 netmask 255.255.0.0 broadcast xxx.xxx.255.255&nbsp;&nbsp; 
<DIV></DIV>&gt;opvpn.conf: 
<DIV></DIV>&gt;remote xxx.xxx.xxx.46 
<DIV></DIV>&gt;port 5001 
<DIV></DIV>&gt;dev tap0 
<DIV></DIV>&gt;up ./up.sh 
<DIV></DIV>&gt;ping 10 
<DIV></DIV>&gt;tun-mtu 1500 
<DIV></DIV>&gt;tun-mtu-extra 32 
<DIV></DIV>&gt;tls-client 
<DIV></DIV>&gt;ca my-ca.crt 
<DIV></DIV>&gt;cert test2.crt 
<DIV></DIV>&gt;key test2.key 
<DIV></DIV>&gt;verb 6 
<DIV></DIV>&gt; 
<DIV></DIV>&gt; 
<DIV></DIV>&gt;I can not get the ip for the tap0 it stays in promisc mode(?ifconfig 
<DIV></DIV>&gt;show no ip for tap0). 
<DIV></DIV>&gt;I also tryed to switch Spanning tree for br0 
<DIV></DIV>&gt;/usr/sbin/brctl stp br0 on 
<DIV></DIV>&gt;Dos not bring anything. 
<DIV></DIV>&gt;So i can not connect to vpn network.Can somewhone help me. Or is the 
<DIV></DIV>&gt;Windows better then Linux??? 
<DIV></DIV>&gt; 
<DIV></DIV>&gt;&nbsp;&nbsp;&nbsp;&nbsp;Thanks, 
<DIV></DIV>
<P>&gt;&nbsp;&nbsp;Herwam </P>
<P>&gt;_______________________________________________ </P>
<DIV></DIV>&gt;Openvpn-users mailing list 
<DIV></DIV>&gt;Openvpn-users@lists.sourceforge.net 
<DIV></DIV></DIV></div><br clear=all><hr>MSN Mobile - Hotmail Nachrichten aufs Handy <a href="http://g.msn.com/8HMADEDE/2746??PS=">Hier klicken </a> </html>

------------=_1083252035-11007-828--
