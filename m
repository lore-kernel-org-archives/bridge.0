From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] Bridging vlans
Date: Mon, 29 Mar 2004 19:39:50 +0200
References: <000101c411ff$635df090$f80210ac@djc.state.id.us>
In-Reply-To: <000101c411ff$635df090$f80210ac@djc.state.id.us>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403291939.50417.bdschuym@pandora.be>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Jeremy Jones <jeremy@samnjack.com>, bridge@lists.osdl.org

On Thursday 25 March 2004 01:23, Jeremy Jones wrote:
> So right now, there's no vlan trunking going on on the link my bridging
> firewall sits on, but I'm going to need to bridge two vlans, 4 and 51.  My
> question is this:  should the vlan interfaces on the linux firewall be
> created first, then bridged; or should the bridge interface be created,
> then vlans bound to that?

You'll need the first. The second method will only work if the packets are 
destined for the bridge itself.

cheers,
Bart

