Date: Wed, 8 Oct 2003 08:58:59 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [Bridge] RE: [VLAN] Re: [PATCH/RFC] Let {ip, arp}tables "see"
	bridged VLAN tagged{I,AR}P packets
Message-Id: <20031008085859.28750553.davem@redhat.com>
In-Reply-To: <1065600565.2572.209.camel@cyan.cph.tpack.net>
References: <5B537508CDBED3118403009027745A210B8C1499@knant18.kna.flextronics.com>
	<1065600565.2572.209.camel@cyan.cph.tpack.net>
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
To: Tommy Christensen <tommy.christensen@tpack.net>
Cc: netdev@oss.sgi.com, vlan@wanfear.com, Christian.Darnell@se.flextronics.com, bdschuym@pandora.be, bridge@osdl.org

On 08 Oct 2003 10:09:25 +0200
Tommy Christensen <tommy.christensen@tpack.net> wrote:

> This is because the VLAN code is mangling shared data.
> You need to do something like this:

This fix is definitely needed and correct, patch applied
thanks.
