Date: Tue, 7 Oct 2003 12:12:58 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [Bridge] Re: [PATCH/RFC] Let {ip, arp}tables "see" bridged VLAN
	tagged {I,AR}P packets
Message-Id: <20031007121258.35c65486.davem@redhat.com>
In-Reply-To: <200310072112.53821.bdschuym@pandora.be>
References: <200310062204.07230.bdschuym@pandora.be>
	<20031007080640.50de4d45.davem@redhat.com>
	<200310072112.53821.bdschuym@pandora.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 7 Oct 2003 21:12:53 +0200
Bart De Schuymer <bdschuym@pandora.be> wrote:

> I've used Stephen's suggestion (out->priv_flags & IFF_802_1Q_VLAN), this
> removes all that cruft.

The new patch definitely looks better.  Unless someone barks
I'll apply this after I catch some sleep.

Thanks Bart.
