Message-ID: <20040621170632.13186.qmail@web53301.mail.yahoo.com>
Date: Mon, 21 Jun 2004 10:06:32 -0700 (PDT)
From: hell know <sp0ck1701@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-593767171-1087837592=:12797"
Subject: [Bridge] control packet flow
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

--0-593767171-1087837592=:12797
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings all.
 
I need a transparent way of selectively controlling packet flow between two network devices such that for example I can "see" [e.g. tcpdump] a packet coming into eth0, queue it, and then manually release it out eth1, one packet at a time.  See diagram below.  (Reason for doing this is to watch the behavior of the device under test to certain packets but I cannot control the speed of the packets from the traffic source so I need an intermediary to do that).
 
[PC/traffic initiator] -- [bridge] -- [device under test]
 
I've looked at nistnet, but that would only work for IP packets, and requires you to use it as a router as I understand it, which wouldn't work here.  I've also looked at IET which seemed to be what I need, but unless I'm doing something wrong it crashes very badly under RHAT 9.0 and SuSE 9.0.
 
Is there any simple way to write a 'hook' into bridge-utils or the kernel to do this?  Are there any other utilities anyone can point me to?
 
Any help would be greatly appreciated!  Thanks in advance!!!

		
---------------------------------
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
--0-593767171-1087837592=:12797
Content-Type: text/html; charset=us-ascii
Content-Disposition: inline

<DIV>Greetings all.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I need a transparent way of selectively controlling packet flow between two network devices such that for example I can "see" [e.g. tcpdump] a packet coming into eth0, queue it, and then manually release it out eth1, one packet at a time.&nbsp; See diagram below.&nbsp; (Reason for doing this is to watch the behavior of the device under test to certain packets but I cannot control the speed of the packets from the traffic source so I need an intermediary to do that).</DIV>
<DIV>&nbsp;</DIV>
<DIV>[PC/traffic initiator] -- [bridge] -- [device under test]</DIV>
<DIV>&nbsp;</DIV>
<DIV>I've looked at nistnet, but that would only work for IP packets, and requires you to use it as a router as&nbsp;I understand it, which wouldn't work here.&nbsp; I've also looked at IET which seemed to be what I need, but&nbsp;unless I'm doing something wrong it crashes very badly under RHAT 9.0 and SuSE 9.0.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Is there any simple way to write a 'hook' into bridge-utils or the kernel to do this?&nbsp; Are there any other utilities anyone can point me to?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Any help would be greatly appreciated!&nbsp; Thanks in advance!!!</DIV><p>
		<hr size=1>Do you Yahoo!?<br>
<a href="http://us.rd.yahoo.com/mail_us/taglines/50x/*http://promotions.yahoo.com/new_mail/static/efficiency.html">Yahoo! Mail</a> - 50x more storage than other providers!
--0-593767171-1087837592=:12797--
