From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: 25 Apr 2007 08:55:54 +0200
Message-ID: <m3vefleydh.fsf@ursa.amorsen.dk>
References: <60846.193.196.136.17.1177202163.squirrel@sleon.dyndns.org>
	<462B9243.6070804@linux-foundation.org>
	<24321.193.196.136.17.1177322032.squirrel@sleon.dyndns.org>
	<60386.193.196.136.17.1177336334.squirrel@sleon.dyndns.org>
	<20070423165614.6eadfaae@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Subject: [Bridge] Re: linux bridge does not bridge bpdu packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

>>>>> "SH" == Stephen Hemminger <shemminger@linux-foundation.org> writes:

SH> -	if (unlikely(is_link_local(dest))) {
SH> -		skb->pkt_type = PACKET_HOST;
SH> +	/* Don't forward 802.1x packets */
SH> +	if (p->br->stp_enabled != BR_NO_STP && is_link_local(dest)) {
SH> +		skb->pkt_type = PACKET_MULTICAST;

Maybe I'm stupid here, but why change behaviour even in the case where
STP is enabled? (The PACKET_HOST -> PACKET_MULTICAST change)


/Benny


