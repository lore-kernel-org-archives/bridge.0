From: "Tomo Ceferin" <tomo@activetools.si>
Subject: RE: [Bridge] Multicast
Date: Thu, 9 Jun 2005 10:48:36 +0200
Message-ID: <043301c56cd0$18151780$825810ac@amon>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050608093152.32e3c9c5@unknown-215.office.pdx.osdl.net>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Stephen Hemminger' <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

> From: Stephen Hemminger [mailto:shemminger@osdl.org] 
> 
> Yes, that is what multicast is.

Then what is broadcast? Multicast should only forward frames to ports that
belong to the multicast groups that frame is designated for. In most networks
replacing multicast with broadcast doesn't present a problem, but when
bandwidth of ports is rather modest (say 10 Mb/s) and you expect video streams
(5 Mb/s) to be distributed via multicast, the topic suddenly becomes rather
important.

Did anyone already have to deal with this? If not, I think it's time bridge
got a proper multicast implementation as well.

Rgds, Tomo


