Date: Wed, 12 May 2004 12:03:50 -0700
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20040512120350.52932c22.davem@redhat.com>
In-Reply-To: <20040510144420.7c033086@dell_ss3.pdx.osdl.net>
References: <200405100816.i4A8Grhl020664@ns.bginfo.net>
	<20040510144420.7c033086@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] bridge -- fix for multiple ports with same
	address
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: krasiyan@bginfo.net, bridge@osdl.org

On Mon, 10 May 2004 14:44:20 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> > seems a bug due to changes in 2.6.6 in mcast and bridge infrastructure 
> > under 2.6.5 same thing works 
> > description 
> > I want to add some vlans with same adress , in one bridge 
> > for pppoe server access concentrator , and some clients with static ip adresses , but in
> > different vlans
> 
> The bridge code was being to picky. The bridge will still work fine when
> there are two interfaces with the same local address, because it is only
> used for setting the source address on the outgoing bridge packets.
> 
> This should fix it.

Applied, thanks Stephen.
