From: Uli Luckas <luckas@musoft.de>
Date: Thu, 18 Sep 2008 21:33:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809182133.59751.luckas@musoft.de>
Subject: [Bridge] delay in bridge learning when forward delay is 0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,
In July 2007 Philip Craig reported the following issue with 'forward delay'=0 
in great detail without receiving an answer. Has Philip's message got lost or 
was his analysis wrong?
The problem becomes a real problem if you bridge a fast LAN to a slow port 
like a bluetooth pan for example.


https://lists.linux-foundation.org/pipermail/bridge/2007-July/005476.html
Philip Craig philipc at snapgear.com 
> Hi,
>
> If you set the bridge forward delay to 0 with:
>         brctl setfd br0 0
> then the bridge does not learn addresses for the first 20 seconds,
> and so it floods everything during this time.
>
> The reason for this is that hold_time() returns 0 after a topology
> change, br_fdb_update() is a no-op if hold_time() is 0 (so that
> 'brctl setmaxage br0 0' can be used to disable learning), and the
> topology change flag isn't cleared for max_age seconds, so nothing
> is learnt during that time.
>
> It seems that the intent of hold_time() is to expire entries that are
> older than forward_delay seconds at the time of the topology change,
> which it does, but then it keeps on checking this expiry again for
> max_age seconds, and bases these checks on the current time rather
> than the time of the change.
>
> A quick fix for the forward delay 0 case would be to skip the
> topology change check if stp is disabled, but if I understand things
> correctly then the expiry isn't right for non-zero cases either.
