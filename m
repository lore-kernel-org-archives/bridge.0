From: jamal <hadi@cyberus.ca>
In-Reply-To: <C0170D0AF1277849A4B4518034F855DD0CFC3B@aiexchange.ai.aiinet.com>
References: <C0170D0AF1277849A4B4518034F855DD0CFC3B@aiexchange.ai.aiinet.com>
Content-Type: text/plain
Message-Id: <1091130000.1022.185.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] RE: [PATCH] (3/4) bridge linkstate handling
Reply-To: hadi@cyberus.ca
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Thu, 29 Jul 2004 19:40:09 -0000
To: "Eble, Dan" <DanE@aiinet.com>
Cc: netdev@oss.sgi.com, bridge@osdl.org, Stephen Hemminger <shemminger@osdl.org>

On Thu, 2004-07-29 at 12:36, Eble, Dan wrote:

> His patch ensures that when a port regains carrier, it is Blocked.
> Before the patch, a Forwarding port would remain Forwarding if the other
> end of the cable were unplugged and then plugged into some other place.

Ok, this is sensible. With a user space control you could probably do
more interesting things with that link info.

> 
> I think I see.  So then when an event happens that might affect the port
> state, the bridge should temporarily block traffic on the port (in case
> the policy daemon will tell it to start blocking) and wait for the
> daemon to respond with a "start blocking" or "continue forwarding"
> decision.  Is that the idea, or have I completely misunderstood?

Everything is still driven by the STP state machine. So no smartness on
the bridge itself; it is just told what to do and it transitions state.
On startup, the port is in blocked state. Only passes BPDUs to user
space. Based on BPDUs and other input (like link info of say unrelated
port) the port state is transitioned. Since all state control is in user
space i.e at one location, no loops should happen. Not sure if it makese
sense.

cheers,
jamal 

