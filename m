Date: Tue, 7 Oct 2003 08:52:41 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20031007085241.7410611a.shemminger@osdl.org>
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
Cc: "David S.Miller" <davem@redhat.com>, netdev@oss.sgi.com, Ben Greear <greearb@candelatech.com>, bridge <bridge@osdl.org>, vlan@wanfear.com

Instead of using vlan_dev_hard_start_xmit_p which causes looking
too deep inside vlan, use the fact that all bridges and vlan devices
are marked with dev->priv_flags.

Instead of:

#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
	    || (out->hard_start_xmit == vlan_dev_hard_start_xmit_p &&
	    VLAN_DEV_INFO(out)->real_dev->hard_start_xmit == br_dev_xmit
#endif

Try:

#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
	    || (out->priv_flags & IFF_802_1Q_VLAN) &&
	    (VLAN_DEV_INFO(out)->real_dev->priv_vlags & IFF_EBRIDGE)
#endif


Gets rid of all the symbol export and other nastiness
