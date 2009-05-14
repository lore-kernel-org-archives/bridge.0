Date: Thu, 14 May 2009 08:35:23 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090514083523.643b640b@nehalam>
In-Reply-To: <1242298904-31325-1-git-send-email-ian.campbell@citrix.com>
References: <1242298904-31325-1-git-send-email-ian.campbell@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] BRIDGE: Do not suppress FDB learning after
 topology change when forward_delay is 0.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ian Campbell <ian.campbell@citrix.com>
Cc: bridge@lists.linux-foundation.org, Ian Campbell <ian.campbell@citrix.com>

On Thu, 14 May 2009 12:01:44 +0100
Ian Campbell <ian.campbell@citrix.com> wrote:

> I recently noticed that my bridges were flooding traffic for a period of time
> after a topology change. These bridges are part of a Xen host and therefore
> have spanning tree disabled and forward_delay of zero. In this situation there
> is no reason not to begin relearning immediately after a topology change.
> 
> The existing code uses hold_time == 0 to suppress learning in br_fdb_update.
> hold_time() returns forward_delay if a topology change has recently occurred
> and ageing_time if not. Setting each of those to zero has slightly different
> semantics: Setting forward_delay to zero effectively means forward immediately
> while setting ageing_time to zero effectively means do not learn.
> 
> The solution is to not learn after a topology change only if forward_delay is
> non-zero but to retain the existing behaviour based on ageing_time if a
> topology change has not occured.


Unless STP is enabled, br_topology_change is bogus.  It looks like,
the following would avoid the problem?

--- a/net/bridge/br_stp.c	2009-05-14 08:33:01.795909321 -0700
+++ b/net/bridge/br_stp.c	2009-05-14 08:34:32.839883992 -0700
@@ -375,7 +375,8 @@ static void br_make_forwarding(struct ne
 
 	if (br->forward_delay == 0) {
 		p->state = BR_STATE_FORWARDING;
-		br_topology_change_detection(br);
+		if (p->br->stp_enable == BR_KERNEL_STP)
+			br_topology_change_detection(br);
 		del_timer(&p->forward_delay_timer);
 	}
 	else if (p->br->stp_enabled == BR_KERNEL_STP)


