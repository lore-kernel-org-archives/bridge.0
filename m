From: Dylan Hall <dylan@citylink.co.nz>
In-Reply-To: <48592CB7.7050103@sysnetsistemi.it>
References: <DBB171FED24842C6AB5F4ECCA91302D2@vpn.com>
	<20080618073354.371e7fbd@catlap>	<DCFB0C9FA9884224936EBAEC97D6FD0A@vpn.com>
	<alpine.DEB.1.00.0806181605330.20500@callisto.moose.malc.org.uk>
	<48592CB7.7050103@sysnetsistemi.it>
Content-Type: multipart/alternative; boundary="=-5jM0ScCV2VyhMehlY8no"
Date: Thu, 19 Jun 2008 15:31:59 +1200
Message-Id: <1213846319.2342.17.camel@collymore.citylink.co.nz>
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
To: bridge@lists.linux-foundation.org
Cc: "c.j" <c.james.cj@gmail.com>


--=-5jM0ScCV2VyhMehlY8no
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

We use vtun which is a userland option, a little slow but offers
rate-limiting and some other nice to have features.

When we require the lowest possible overhead option, we use the etherip
kernel patches.


Dylan


On Wed, 2008-06-18 at 17:41 +0200, Francesco Dolcini wrote:

> Malcolm Scott wrote:
> > At 21:02 today, c.j wrote:
> > 
> >>> You can setup a tunnel with OpenVPN. You'd get a tap device on
> >>> both sides which can be bridged with eth.
> >> Thanks. But maybe we don't want OpenVPN for VPN. Now I can't get why kernel
> >> do not support that. Have some disadvantages?
> > 
> > I'm not sure if this is even possible using standard protocols.  Bridging is 
> > for Ethernet; PPP is not Ethernet.  So this would require some sort of 
> > nonstandard Ethernet-over-PPP encapsulation protocol, and would only make 
> see standard rfc3518, http://www.ietf.org/rfc/rfc3518.txt, I think there 
> is a (old?) patch  flying around for this ...
> 
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

--=-5jM0ScCV2VyhMehlY8no
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.16.3">
</HEAD>
<BODY>
We use vtun which is a userland option, a little slow but offers rate-limiting and some other nice to have features.<BR>
<BR>
When we require the lowest possible overhead option, we use the etherip kernel patches.<BR>
<BR>
<BR>
Dylan<BR>
<BR>
<BR>
On Wed, 2008-06-18 at 17:41 +0200, Francesco Dolcini wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Malcolm Scott wrote:</FONT>
<FONT COLOR="#000000">&gt; At 21:02 today, c.j wrote:</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt;&gt;&gt; You can setup a tunnel with OpenVPN. You'd get a tap device on</FONT>
<FONT COLOR="#000000">&gt;&gt;&gt; both sides which can be bridged with eth.</FONT>
<FONT COLOR="#000000">&gt;&gt; Thanks. But maybe we don't want OpenVPN for VPN. Now I can't get why kernel</FONT>
<FONT COLOR="#000000">&gt;&gt; do not support that. Have some disadvantages?</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; I'm not sure if this is even possible using standard protocols.  Bridging is </FONT>
<FONT COLOR="#000000">&gt; for Ethernet; PPP is not Ethernet.  So this would require some sort of </FONT>
<FONT COLOR="#000000">&gt; nonstandard Ethernet-over-PPP encapsulation protocol, and would only make </FONT>
<FONT COLOR="#000000">see standard rfc3518, <A HREF="http://www.ietf.org/rfc/rfc3518.txt">http://www.ietf.org/rfc/rfc3518.txt</A>, I think there </FONT>
<FONT COLOR="#000000">is a (old?) patch  flying around for this ...</FONT>


<FONT COLOR="#000000">_______________________________________________</FONT>
<FONT COLOR="#000000">Bridge mailing list</FONT>
<FONT COLOR="#000000"><A HREF="mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-foundation.org</A></FONT>
<FONT COLOR="#000000"><A HREF="https://lists.linux-foundation.org/mailman/listinfo/bridge">https://lists.linux-foundation.org/mailman/listinfo/bridge</A></FONT>
</PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-5jM0ScCV2VyhMehlY8no--

