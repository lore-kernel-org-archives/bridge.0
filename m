From: Bart De Schuymer <bdschuym@pandora.be>
Date: Mon, 6 Oct 2003 22:55:38 +0200
References: <200310062204.07230.bdschuym@pandora.be>
	<20031006131916.6a7ba5c0.shemminger@osdl.org>
In-Reply-To: <20031006131916.6a7ba5c0.shemminger@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310062255.38789.bdschuym@pandora.be>
Subject: [Bridge] Re: [PATCH/RFC] Let {ip,
	arp}tables "see" bridged VLAN tagged {I, AR}P packets
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "David S.Miller" <davem@redhat.com>, netdev@oss.sgi.com, Ben Greear <greearb@candelatech.com>, bridge <bridge@osdl.org>, vlan@wanfear.com

On Monday 06 October 2003 22:19, Stephen Hemminger wrote:
> I can test the no VLAN case, but actual VLAN's are a little harder to
> setup.

Setting up vlan's is easy:
brctl addbr br0
brctl addif br0 eth0
ifconfig br0 $address
vconfig add br0 1000
ifconfig br0.1000 $address

> How does this affect the ability to rmmod either vlan or bridge?

Well, when br0.1000 exists and you then rmmod the bridge, it doesn't work. The 
way to do it is rmmod 8021q;rmmod bridge. I came across this issue, but I 
assumed it was not my fault. I thought the problem would exist without my 
code too, but I'm not sure if I checked. What also doesn't work is rmmod 
bridge followed by rmmod 8021q on a different console. I now just realize 
this is probably because the bridge depends on 8021q and we thus get a 
deadlock.
I think the right solution to this problem is, when rmmod bridge happens, it 
removes any tagged bridge devices first.

cheers,
Bart

