From: Dylan Hall <dylan@citylink.co.nz>
In-Reply-To: <20070416111137.2b046ae8@dxpl.pdx.osdl.net>
References: <1176676171.3713.16.camel@collymore.citylink.co.nz>
	<20070416111137.2b046ae8@dxpl.pdx.osdl.net>
Content-Type: multipart/alternative; boundary="=-uOmHBkUQgFFtWlkcI9aa"
Date: Tue, 17 Apr 2007 09:58:58 +1200
Message-Id: <1176760738.5336.11.camel@collymore.citylink.co.nz>
Mime-Version: 1.0
Subject: Re: [Bridge] Feature enhancement - Disable unicast flooding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@linux-foundation.org

This is a multi-part message in MIME format...

--=-uOmHBkUQgFFtWlkcI9aa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I looked at ebtables initially. My first plan was to use a perl script
using pcap to listen on the interfaces and generate ebtables rules as
new hosts are detected.

I had two concerns with this approach, the first is that there are
approx 1000 hosts on the vlans I'm working with, which is a lot of
ebtables rules (linked-lists are used, and hence forwarding performance
would suffer - is this correct?). 

The second concern is that the hardware I'm using are little embedded
boxes (Soekris), so with only a 133Mhz CPU, any helper scripts I use to
maintain the ebtables rules are going to use precious CPU resources I
would rather were available for forwarding.

Given those concerns, I decided I was essentially duplicating the
learning process that already exists in the bridging code, and hence
duplicating effort rather inefficiently.

That said, a dedicated ebtables module, one that possibly references the
existing bridging database might be a plan? I have no experience writing
modules like that, how easy/hard would it be to write such a module?

Thanks,

Dylan


On Mon, 2007-04-16 at 11:11 -0700, Stephen Hemminger wrote:

> On Mon, 16 Apr 2007 10:29:31 +1200
> Dylan Hall <dylan@citylink.co.nz> wrote:
> 
> > For the project I'm working on I require that the bridging code not
> > flood unicast frames when the destination mac address is unknown,
> > similar to Cisco's "switchport block unicast" feature
> > (http://www.cisco.com/en/US/products/ps6406/products_configuration_guide_chapter09186a00805a761a.html#wp1087814).
> > 
> > I have produced a small patch (against 2.6.20.4) to control this feature
> > per bridge (rather than per port like a Cisco).
> > 
> > Have I gone about implementing this correctly?
> > 
> > Is this something other people may find useful, and hence worth
> > incorporating into the mainstream code?
> > 
> > Is it worth the effort of taking this one step further, and controlling
> > the behaviour per port rather than per bridge?
> > 
> > Thanks,
> > 
> > Dylan
> > 
> > 
> > 
> 
> Maybe. But this kind of thing is better done with a ebtables module.
> That way it can be more easily integrated with other security stuff.

--=-uOmHBkUQgFFtWlkcI9aa
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.1">
</HEAD>
<BODY>
I looked at ebtables initially. My first plan was to use a perl script using pcap to listen on the interfaces and generate ebtables rules as new hosts are detected.<BR>
<BR>
I had two concerns with this approach, the first is that there are approx 1000 hosts on the vlans I'm working with, which is a lot of ebtables rules (linked-lists are used, and hence forwarding performance would suffer - is this correct?). <BR>
<BR>
The second concern is that the hardware I'm using are little embedded boxes (Soekris), so with only a 133Mhz CPU, any helper scripts I use to maintain the ebtables rules are going to use precious CPU resources I would rather were available for forwarding.<BR>
<BR>
Given those concerns, I decided I was essentially duplicating the learning process that already exists in the bridging code, and hence duplicating effort rather inefficiently.<BR>
<BR>
That said, a dedicated ebtables module, one that possibly references the existing bridging database might be a plan? I have no experience writing modules like that, how easy/hard would it be to write such a module?<BR>
<BR>
Thanks,<BR>
<BR>
Dylan<BR>
<BR>
<BR>
On Mon, 2007-04-16 at 11:11 -0700, Stephen Hemminger wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">On Mon, 16 Apr 2007 10:29:31 +1200</FONT>
<FONT COLOR="#000000">Dylan Hall &lt;<A HREF="mailto:dylan@citylink.co.nz">dylan@citylink.co.nz</A>&gt; wrote:</FONT>

<FONT COLOR="#000000">&gt; For the project I'm working on I require that the bridging code not</FONT>
<FONT COLOR="#000000">&gt; flood unicast frames when the destination mac address is unknown,</FONT>
<FONT COLOR="#000000">&gt; similar to Cisco's &quot;switchport block unicast&quot; feature</FONT>
<FONT COLOR="#000000">&gt; (<A HREF="http://www.cisco.com/en/US/products/ps6406/products_configuration_guide_chapter09186a00805a761a.html#wp1087814">http://www.cisco.com/en/US/products/ps6406/products_configuration_guide_chapter09186a00805a761a.html#wp1087814</A>).</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; I have produced a small patch (against 2.6.20.4) to control this feature</FONT>
<FONT COLOR="#000000">&gt; per bridge (rather than per port like a Cisco).</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Have I gone about implementing this correctly?</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Is this something other people may find useful, and hence worth</FONT>
<FONT COLOR="#000000">&gt; incorporating into the mainstream code?</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Is it worth the effort of taking this one step further, and controlling</FONT>
<FONT COLOR="#000000">&gt; the behaviour per port rather than per bridge?</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Thanks,</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Dylan</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; </FONT>

<FONT COLOR="#000000">Maybe. But this kind of thing is better done with a ebtables module.</FONT>
<FONT COLOR="#000000">That way it can be more easily integrated with other security stuff.</FONT>
</PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-uOmHBkUQgFFtWlkcI9aa--
