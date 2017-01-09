Return-Path: <johannes@sipsolutions.net>
Message-ID: <1483965843.17582.37.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 09 Jan 2017 13:44:03 +0100
In-Reply-To: <20170109124231.GA9086@otheros>
References: <20170102193214.31723-1-linus.luessing@c0d3.blue>
	<1483706872.4089.8.camel@sipsolutions.net>
	<20170107151530.GG3134@otheros>
	<1483949149.17582.1.camel@sipsolutions.net>
	<20170109124231.GA9086@otheros>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next] bridge: multicast to unicast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Braun <michael-dev@fami-braun.de>, "David S . Miller" <davem@davemloft.net>, Felix Fietkau <nbd@nbd.name>


> >          A host SHOULD silently discard a datagram that is received via
> >          a link-layer broadcast (see Section 2.4) but does not specify
> >          an IP multicast or broadcast destination address.
> 
> This example is the other way round. It specifies how the IP
> destination should look like in case of link-layer broadcast. Not
> how the link-layer destination should look like in case of a
> multicast/broadcast IP destination.

You stopped reading too early - snipped the context part for you :)

johannes
