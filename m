Return-Path: <bdschuym@pandora.be>
Message-ID: <537E4889.5000306@pandora.be>
Date: Thu, 22 May 2014 20:57:13 +0200
From: Bart De Schuymer <bdschuym@pandora.be>
MIME-Version: 1.0
References: <537A6E5C.6090602@pandora.be>	<537C5A6C.3030809@davidnewall.com>	<537CF5A2.3080401@pandora.be>
	<20140521.161841.1806439174351824310.davem@davemloft.net>
In-Reply-To: <20140521.161841.1806439174351824310.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Revert 462fb2af9788a82a534f8184abfde31574e1cfa0
 (bridge : Sanitize skb before it enters the IP stack)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, davidn@davidnewall.com, bridge@lists.linux-foundation.org, fw@strlen.de, stephen@networkplumber.org, netfilter-devel@vger.kernel.org

David Miller schreef op 21/05/2014 22:18:
> From: Bart De Schuymer <bdschuym@pandora.be>
>> There's no reason why they should overlap in the cb: it's 48 bytes
>> big, so big enough to hold both struct br_input_skb_cb and struct
>> inet_skb_parm. The original problem was introduced when
>> BR_INPUT_SKB_CB was introduced (around Feb 27, 2010), so fixing
>> BR_INPUT_SKB_CB seems most appropriate to me.
>
> So you are suggesting the patch below will fix everything?

Assuming:
- David Newall's worries about IPCB are incorrect
- you also revert the commit mentioned by David 
(462fb2af9788a82a534f8184abfde31574e1cfa0 (bridge :
Sanitize skb before it enters the IP stack))

Then I give it a good chance the regression will be gone with your patch.

> We never should have added bridging netfilter to the tree in the
> first place, I wish I had better judgment back then.

Feel free to deprecate it. This is my last spare-time involvement.

Please apply following patch:

diff --git a/MAINTAINERS b/MAINTAINERS
index f5de16e..2369bae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3163,10 +3163,9 @@ S:	Maintained
  F:	drivers/scsi/eata_pio.*

  EBTABLES
-M:	Bart De Schuymer <bart.de.schuymer@pandora.be>
  L:	netfilter-devel@vger.kernel.org
  W:	http://ebtables.sourceforge.net/
-S:	Maintained
+S:	Orphan
  F:	include/linux/netfilter_bridge/ebt_*.h
  F:	include/uapi/linux/netfilter_bridge/ebt_*.h
  F:	net/bridge/netfilter/ebt*.c

