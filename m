Message-ID: <20041112195709.90434.qmail@web54502.mail.yahoo.com>
From: juan morales <moralesjuan765@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-93365580-1100289429=:89854"
Subject: [Bridge] bridge + squid
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Fri, 12 Nov 2004 19:57:21 -0000
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

--0-93365580-1100289429=:89854
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Srs
I have a linux like a bridge
 
LAN  - BRIGE -ROUTER
The bridge has a ip ( non public IP)
The bridge is working fine but y need to set up the Squid on the same machine where is installed the BRIDGE.
 
I was looking for the answers and say:
 

httpd_accel_host virtual 

httpd_accel_port 80 

httpd_accel_with_proxy on 

httpd_accel_uses_host_header on

 

and put this rules with iptables

iptables #8722;t nat #8722;A PREROUTING #8722;i eth0 #8722;p tcp #8722;#8722;dport 80 #8722;j REDIRECT  #8722;#8722;to#8722;port 3128

eth0 go to Router

eth1 go to LAN

iptables #8722;A INPUT #8722;i interface #8722;p tcp #8722;d your_bridge_ip #8722;s local#8722;network #8722;#8722;dport 3128 #8722;m state

#8722;#8722;state NEW,ESTABLISHED #8722;j ACCEPT

(replace interface by eth1 LAN)

But it don't work because i see the /var/log/squid/access.log and not see anything

Thank in advance for your help

juan

 

 

 

 


			
---------------------------------
Do you Yahoo!?
 Check out the new Yahoo! Front Page. www.yahoo.com
--0-93365580-1100289429=:89854
Content-Type: text/html; charset=us-ascii
Content-Disposition: inline

<DIV>Hi Srs</DIV>
<DIV>I have a linux like a bridge</DIV>
<DIV>&nbsp;</DIV>
<DIV>LAN&nbsp; - BRIGE -ROUTER</DIV>
<DIV>The bridge has a ip ( non public IP)</DIV>
<DIV>The bridge is working fine but y need to set up the Squid on the same machine where is installed the BRIDGE.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I was looking for the answers and say:</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face="Times New Roman" size=3>
<P align=left>httpd_accel_host virtual </P>
<P align=left></FONT><FONT face="Times New Roman" size=3>httpd_accel_port 80 </FONT><FONT face=Symbol size=3></P></FONT><FONT face="Times New Roman" size=3>
<P align=left>httpd_accel_with_proxy on </FONT><FONT face=Symbol size=3></P></FONT><FONT face="Times New Roman" size=3>
<P align=left>httpd_accel_uses_host_header on</P>
<P align=left>&nbsp;</P>
<P align=left>and put this rules with iptables</P><FONT face="Times New Roman" size=3>
<P align=left>iptables &#8722;t nat &#8722;A PREROUTING &#8722;i eth0 &#8722;p tcp &#8722;&#8722;dport 80 &#8722;j REDIRECT&nbsp; &#8722;&#8722;to&#8722;port 3128</P>
<P align=left>eth0 go to Router</P>
<P align=left>eth1 go to LAN</P><FONT face="Times New Roman" size=3>
<P align=left>iptables &#8722;A INPUT &#8722;i </FONT><B><FONT face="Times New Roman" size=3>interface </B></FONT><FONT face="Times New Roman" size=3>&#8722;p tcp &#8722;d </FONT><B><FONT face="Times New Roman" size=3>your_bridge_ip </B></FONT><FONT face="Times New Roman" size=3>&#8722;s </FONT><B><FONT face="Times New Roman" size=3>local&#8722;network </B></FONT><FONT face="Times New Roman" size=3>&#8722;&#8722;dport 3128 &#8722;m state</P>
<P align=left>&#8722;&#8722;state NEW,ESTABLISHED &#8722;j ACCEPT</P></FONT>
<P align=left>(replace interface by eth1 LAN)</P>
<P align=left>But it don't work because i see the /var/log/squid/access.log and not see anything</P>
<P align=left>Thank in advance for your help</P>
<P align=left>juan</P>
<P align=left>&nbsp;</P>
<P align=left>&nbsp;</P>
<P align=left>&nbsp;</P>
<P align=left>&nbsp;</P></FONT></FONT></DIV><p>
	
		<hr size=1>Do you Yahoo!?<br> 
Check out the new Yahoo! Front Page. <a href="http://www.yahoo.com">www.yahoo.com</a>
--0-93365580-1100289429=:89854--
