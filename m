From: Uli Luckas <u.luckas@road.de>
Date: Fri, 15 May 2009 12:08:33 +0200
References: <1242298904-31325-1-git-send-email-ian.campbell@citrix.com>
	<20090514083523.643b640b@nehalam>
In-Reply-To: <20090514083523.643b640b@nehalam>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905151208.33915.u.luckas@road.de>
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
To: bridge@lists.linux-foundation.org
Cc: Ian Campbell <ian.campbell@citrix.com>

On Thursday, 14. May 2009, Stephen Hemminger wrote:
> On Thu, 14 May 2009 12:01:44 +0100
> Ian Campbell <ian.campbell@citrix.com> wrote:
> 
> > I recently noticed that my bridges were flooding traffic for a period of time
> > after a topology change. These bridges are part of a Xen host and therefore
> > have spanning tree disabled and forward_delay of zero. In this situation there
> > is no reason not to begin relearning immediately after a topology change.
> > 
> > The existing code uses hold_time == 0 to suppress learning in br_fdb_update.
> > hold_time() returns forward_delay if a topology change has recently occurred
> > and ageing_time if not. Setting each of those to zero has slightly different
> > semantics: Setting forward_delay to zero effectively means forward immediately
> > while setting ageing_time to zero effectively means do not learn.
> > 
> > The solution is to not learn after a topology change only if forward_delay is
> > non-zero but to retain the existing behaviour based on ageing_time if a
> > topology change has not occured.
> 
> 
> Unless STP is enabled, br_topology_change is bogus.  It looks like,
> the following would avoid the problem?
> 
> --- a/net/bridge/br_stp.c	2009-05-14 08:33:01.795909321 -0700
> +++ b/net/bridge/br_stp.c	2009-05-14 08:34:32.839883992 -0700
> @@ -375,7 +375,8 @@ static void br_make_forwarding(struct ne
>  
>  	if (br->forward_delay == 0) {
>  		p->state = BR_STATE_FORWARDING;
> -		br_topology_change_detection(br);
> +		if (p->br->stp_enable == BR_KERNEL_STP)
> +			br_topology_change_detection(br);
>  		del_timer(&p->forward_delay_timer);
>  	}
>  	else if (p->br->stp_enabled == BR_KERNEL_STP)
> 
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
> 

Hi Stephen,
should that fix this open issue "delay in bridge learning when forward delay is 0" [1]?

Uli

1) https://lists.linux-foundation.org/pipermail/bridge/2008-October/006059.html



-- 

------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Head of Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 62 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing director: Hans-Peter Constien
