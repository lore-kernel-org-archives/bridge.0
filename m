Subject: RE: [Bridge] BCP status
From: Petter Larsen <petter.larsen@morecom.no>
In-Reply-To: <C0170D0AF1277849A4B4518034F855DD0CFC8D@aiexchange.ai.aiinet.com>
References: <C0170D0AF1277849A4B4518034F855DD0CFC8D@aiexchange.ai.aiinet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094030836.3528.177.camel@pla.lokal.lan>
Mime-Version: 1.0
Date: Wed, 01 Sep 2004 11:27:16 +0200
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Eble, Dan" <DanE@aiinet.com>
Cc: winter@jurai.net, bridge@lists.osdl.org

Hello

> The status of the BCP code is that it is used in some Applied Innovation
> products, but it is not a standard Linux feature because no one has
> ported it to the newest versions of the kernel and pppd.  
Ok. The patches that you sent to the mailing list in March, are they the
latest from your side? You mentioned that you had some plug-ins for HDLC
ppp-layer drivers.  

Are you working on this now, or are you finished? 


> Also, a good
> fellow named Matthew N. Dodd was also in touch with me several months
> ago.  I do not know the status of BCP in his company's products, but you
> should have no problem finding him with a web search engine.

I think I found him, and he is on the CC list.
Dodd: Have you extended this code or used it in any products?
> 

> The BCP state machine for PPPD was already a couple years old when I was
> assigned to port it to our Linux-based products.  I believe it is based
> on RFC 1638.  It did not support STP at all, so I added both the old RFC
> 1638 "Spanning-Tree-Protocol" option and the newer RFC 2878
> "Management-Inline" option.  I do not remember making any other
> significant additions.

Ok

> 
> Note that BCP is not directly relevant to the kernel bridge driver.  BCP
> simply provides ethernet over PPP; whether to bridge or to route the
> resulting network interface is up to you.

Ok 

Regards
-- 
Petter Larsen
cand. scient.
moreCom as
913 17 222
