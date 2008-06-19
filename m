From: Dylan Hall <dylan@citylink.co.nz>
In-Reply-To: <56CC982A1CAD43C483A8F97167A6094C@vpn.com>
References: <DBB171FED24842C6AB5F4ECCA91302D2@vpn.com>
	<20080618073354.371e7fbd@catlap>	<DCFB0C9FA9884224936EBAEC97D6FD0A@vpn.com>
	<alpine.DEB.1.00.0806181605330.20500@callisto.moose.malc.org.uk>
	<48592CB7.7050103@sysnetsistemi.it>
	<1213846319.2342.17.camel@collymore.citylink.co.nz>
	<56CC982A1CAD43C483A8F97167A6094C@vpn.com>
Content-Type: multipart/alternative; boundary="=-+S4DVjtChw5wT4kCcPmf"
Date: Fri, 20 Jun 2008 10:28:23 +1200
Message-Id: <1213914503.16230.22.camel@collymore.citylink.co.nz>
Mime-Version: 1.0
Subject: Re: [Bridge] kernel doesn't support bridge with a ppp interface ?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "c.j" <C.James.CJ@gmail.com>, bridge@lists.linux-foundation.org
Cc: linux-ppp@vger.kernel.org


--=-+S4DVjtChw5wT4kCcPmf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

It's a little unclear what your setup is, but let me take a guess and
make some suggestions :)

1)  Assuming a setup something like the following

LAN A --- (ETH) [LINUX A] (PPP) [LINUX B] (ETH) --- LAN B

In the above, I would assume the goal is to join (bridge) LAN A and LAN
B together?

You could configure basic IP across the PPP link so that the two linux
boxes can reach each other. 

You then configure something like vtun or etherip to run over the IP/PPP
link between the two linux boxes.

Finally you setup bridges at each end, the result would look something
like:

LAN A --- (ETH){BR on LINUX A}(TUN) --- (PPP) --- (TUN){BR on LINUX
B}(ETH) --- LAN B

The etherip has the caveat that it doesn't support fragmentation so will
only work if the PPP link supports a large MTU, say 1540 or greater.


2) A less likely scenario is

PPP Client --- (ETH)[LINUX](ETH) --- PPP Server

In the above you want to get your PPP session going through a linux box
in the middle.

If the PPP is PPPoE, adding the ETH's to a bridge on the linux box
should be sufficient. 

If it's some other variant of PPP you might be able to use L2TP to
tunnel the PPP between end points. I've seen this done in a DSL/BRAS
environment where the BRAS wasn't directly attached to the DSLAMs. I
suspect this is far from straight forward.



Dylan




On Thu, 2008-06-19 at 23:49 +0800, c.j wrote:

> ﻿ 
> 
> >We use vtun which is a userland option, a little slow but offers
> rate-limiting and some other nice to have features.
> 
> >When we require the lowest possible overhead option, we use the
> etherip kernel patches.
>  
> Thanks for your kind suggestion.  Whether the etherip patches can
> transmit ppp packet? Since I'm not  familiar  with them , I need some
> time to read them if so.
>  
> Regards~
>  
> --
> c.j

--=-+S4DVjtChw5wT4kCcPmf
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.16.3">
</HEAD>
<BODY BGCOLOR="#ffffff">
It's a little unclear what your setup is, but let me take a guess and make some suggestions :)<BR>
<BR>
1)&nbsp; Assuming a setup something like the following<BR>
<BR>
LAN A --- (ETH) [LINUX A] (PPP) [LINUX B] (ETH) --- LAN B<BR>
<BR>
In the above, I would assume the goal is to join (bridge) LAN A and LAN B together?<BR>
<BR>
You could configure basic IP across the PPP link so that the two linux boxes can reach each other. <BR>
<BR>
You then configure something like vtun or etherip to run over the IP/PPP link between the two linux boxes.<BR>
<BR>
Finally you setup bridges at each end, the result would look something like:<BR>
<BR>
LAN A --- (ETH){BR on LINUX A}(TUN) --- (PPP) --- (TUN){BR on LINUX B}(ETH) --- LAN B<BR>
<BR>
The etherip has the caveat that it doesn't support fragmentation so will only work if the PPP link supports a large MTU, say 1540 or greater.<BR>
<BR>
<BR>
2) A less likely scenario is<BR>
<BR>
PPP Client --- (ETH)[LINUX](ETH) --- PPP Server<BR>
<BR>
In the above you want to get your PPP session going through a linux box in the middle.<BR>
<BR>
If the PPP is PPPoE, adding the ETH's to a bridge on the linux box should be sufficient. <BR>
<BR>
If it's some other variant of PPP you might be able to use L2TP to tunnel the PPP between end points. I've seen this done in a DSL/BRAS environment where the BRAS wasn't directly attached to the DSLAMs. I suspect this is far from straight forward.<BR>
<BR>
<BR>
<BR>
Dylan<BR>
<BR>
<BR>
<BR>
<BR>
On Thu, 2008-06-19 at 23:49 +0800, c.j wrote:<BR>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&#65279; </FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&gt;We use vtun which is a userland option, a little slow but offers rate-limiting and some other nice to have features.</FONT><BR>
    <BR>
    <FONT COLOR="#000000">&gt;When we require the lowest possible overhead option, we use the etherip kernel patches.</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Thanks for your kind suggestion.&nbsp; Whether the etherip patches can transmit ppp packet?&nbsp;Since I'm not&nbsp;&nbsp;familiar&nbsp; with them , I need some time to read them if so.</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Regards~</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">--</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">c.j</FONT></FONT>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-+S4DVjtChw5wT4kCcPmf--

