Date: Tue, 7 Oct 2003 08:06:40 -0700
From: "David S. Miller" <davem@redhat.com>
Message-Id: <20031007080640.50de4d45.davem@redhat.com>
In-Reply-To: <200310062204.07230.bdschuym@pandora.be>
References: <200310062204.07230.bdschuym@pandora.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH/RFC] Let {ip,
 arp}tables "see" bridged VLAN tagged {I,AR}P packets
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: netdev@oss.sgi.com, greearb@candelatech.com, bridge@osdl.org, vlan@wanfear.com, shemminger@osdl.org

On Mon, 6 Oct 2003 22:04:07 +0200
Bart De Schuymer <bdschuym@pandora.be> wrote:

> -	unsigned long hh[16 / sizeof(unsigned long)];
> +	unsigned char hh[18];

Maybe don't do this?  It should be aligned on a 'long' boundry I
think.

The only real hard objection I have with the patch is the vlan xmit
routine pointer crap, just export the symbol.

Once you fix that I'll apply your patch as long as Stephen has no
objections.

