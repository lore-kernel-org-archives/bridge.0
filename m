Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bridge] BCP status
Date: Tue, 24 Aug 2004 08:44:48 -0400
Message-ID: <C0170D0AF1277849A4B4518034F855DD0CFC8D@aiexchange.ai.aiinet.com>
From: "Eble, Dan" <DanE@aiinet.com>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Petter Larsen <petter.larsen@morecom.no>
Cc: bridge@lists.osdl.org

Peter,

First, my email address is dane@aiinet.com.

The status of the BCP code is that it is used in some Applied Innovation
products, but it is not a standard Linux feature because no one has
ported it to the newest versions of the kernel and pppd.  Also, a good
fellow named Matthew N. Dodd was also in touch with me several months
ago.  I do not know the status of BCP in his company's products, but you
should have no problem finding him with a web search engine.

The BCP state machine for PPPD was already a couple years old when I was
assigned to port it to our Linux-based products.  I believe it is based
on RFC 1638.  It did not support STP at all, so I added both the old RFC
1638 "Spanning-Tree-Protocol" option and the newer RFC 2878
"Management-Inline" option.  I do not remember making any other
significant additions.

Note that BCP is not directly relevant to the kernel bridge driver.  BCP
simply provides ethernet over PPP; whether to bridge or to route the
resulting network interface is up to you.

Regards,
-- 
Dan Eble <dane@aiinet.com>  _____  .
Software Engineer          |  _  |/|
Applied Innovation Inc.    | |_| | |
http://www.aiinet.com/     |__/|_|_|

> -----Original Message-----
> From: bridge-bounces@lists.osdl.org 
> [mailto:bridge-bounces@lists.osdl.org] On Behalf Of Petter Larsen
> Sent: Friday, August 20, 2004 8:15 AM
> To: dan@aiinet.com
> Cc: bridge@lists.osdl.org; shemminger@osdl.org
> Subject: [Bridge] BCP status
> 
> 
> Hello
> 
> I can see that BCP is implemeted and posted as patches on the
> mailinglist.
> 
> Can you tell me the status of this work?
> What is the status of getting this code integrated directly in the
> vanilla kernel at kernel.org both 2.4.x and 2.6.x?
> 
> Are the patches for pppd sent to the maintainers of the pppd?
> 
> We are evaluating to use this under a XScale processor.
> 
> Best regards
> -- 
> Petter Larsen
> cand. scient.
> moreCom as
> 913 17 222
> 

