Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 29 Jul 2004 12:36:38 -0400
Message-ID: <C0170D0AF1277849A4B4518034F855DD0CFC3B@aiexchange.ai.aiinet.com>
From: "Eble, Dan" <DanE@aiinet.com>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] RE: [PATCH] (3/4) bridge linkstate handling
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: hadi@cyberus.ca
Cc: netdev@oss.sgi.com, bridge@osdl.org, Stephen Hemminger <shemminger@osdl.org>

> I must have misunderstood Stevens patch then. Are you saying 
> it opens a
> port that was previously blocked because a link was reinserted?
> Or the other way round: it would put a port that was 
> previously blocked
> into forwarding state because a previously forwarding link had a link
> going down?
> I think all this needs to be policy driven.

His patch ensures that when a port regains carrier, it is Blocked.
Before the patch, a Forwarding port would remain Forwarding if the other
end of the cable were unplugged and then plugged into some other place.



> 2) Other inputs like Links going up or down or VRRP state 
> changes for HA
> or somebody farting (pardon my language, just trying to drive a point)
> also need to feed to the same policy decision making engine. 
> The result
> of the policy engine is a STP state transition for a port.

I think I see.  So then when an event happens that might affect the port
state, the bridge should temporarily block traffic on the port (in case
the policy daemon will tell it to start blocking) and wait for the
daemon to respond with a "start blocking" or "continue forwarding"
decision.  Is that the idea, or have I completely misunderstood?

