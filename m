From: Bernhard Weirich <bernhard.weirich@riedel.net>
Content-Type: multipart/alternative; boundary="=-EgrRHVNTgSXf4jbtFH6R"
Date: Tue, 3 Feb 2009 18:03:49 +0100
Message-ID: <1233680629.6415.12.camel@hactar.vie.riedel.net>
MIME-Version: 1.0
Subject: [Bridge] RSTP problem after ifupdown
Reply-To: bernhard.weirich@riedel.net
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--=-EgrRHVNTgSXf4jbtFH6R
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

I'm using RSTP which is working most of the time, but there is one
problem I ran into when I tried to reconfigure the bridge interface.

I have a bridge br0 with an interface eth0.
both are up and running,
then I do :
# ifconfig br0 down
br0: port 1(eth0) entering disabled state
# ifconfig br0 up
#

The strange thing is that eth0 is still up but the stp link is not
reactivated from disabled to learning.
When I unplug eth0 and replug it the link enters learning and forwarding
stages as usual.
So I assume that the kernel deactivates the link without the knowledge
of the bridge, and so for the bridge there is no need to reactivate it.

Is this a problem just with my config or can someone else confirm this
behaviour?

Regards,
Bernhard Weirich

--=-EgrRHVNTgSXf4jbtFH6R
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.18.3">
</HEAD>
<BODY>
Hello,<BR>
<BR>
I'm using RSTP which is working most of the time, but there is one problem I ran into when I tried to reconfigure the bridge interface.<BR>
<BR>
I have a bridge br0 with an interface eth0.<BR>
both are up and running,<BR>
then I do :<BR>
# ifconfig br0 down<BR>
br0: port 1(eth0) entering disabled state<BR>
# ifconfig br0 up<BR>
#<BR>
<BR>
The strange thing is that eth0 is still up but the stp link is not reactivated from disabled to learning.<BR>
When I unplug eth0 and replug it the link enters learning and forwarding stages as usual.<BR>
So I assume that the kernel deactivates the link without the knowledge of the bridge, and so for the bridge there is no need to reactivate it.<BR>
<BR>
Is this a problem just with my config or can someone else confirm this behaviour?<BR>
<BR>
Regards,<BR>
Bernhard Weirich
</BODY>
</HTML>

--=-EgrRHVNTgSXf4jbtFH6R--
