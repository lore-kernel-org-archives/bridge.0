Date: Fri, 8 May 2009 20:42:33 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090508204233.4aaed9ec@nehalam>
In-Reply-To: <de7adc5e0905081808h43e5ef84m113c4dd868077bf1@mail.gmail.com>
References: <de7adc5e0905081431v58989abch5e7271de302afd99@mail.gmail.com>
	<20090508155418.7acc7fbf@nehalam>
	<de7adc5e0905081620s69f3e874xa50636b0b6fc65d3@mail.gmail.com>
	<20090508162719.6cbc3022@nehalam>
	<de7adc5e0905081808h43e5ef84m113c4dd868077bf1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] 2.6.27: persistent MAC assignment to bridge not working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Daniel Robbins <drobbins@funtoo.org>
Cc: bridge@lists.linux-foundation.org, "Pavel V. Emelianov" <xemul@sw.ru>

On Fri, 8 May 2009 19:08:06 -0600
Daniel Robbins <drobbins@funtoo.org> wrote:

> Your code in 2.6.27 works perfectly.
> 
> Let me tell you what I was doing wrong, and if you could tell me why
> it didn't work, I'd really appreciate it :) (Might also be a good
> addition to the Net:Bridge FAQ):
> 
> # brctl addbr br0
> # brctl addif br0 eth0
> # ifconfig br0 10.0.1.220 netmask 255.255.255.0
> # brctl addif br0 veth100.0
> # brctl addif br0 veth102.0
> 
> Now, the zinger:
> 
> # ifconfig br0 hw ether "12:34:56:78:90:ab"
> 
> ^^ By using a unique MAC address, this command totally disables my
> bridge, and the machine can no longer send or receive data.
> 
> If I use a MAC that is already in use by my bridge's sub-interfaces,
> however, (ie. from eth0, veth100.0 or veth102.0) then there's no
> problem, and everything works, and the MAC address is sticky as it
> should be.
> 
> So this was the mistake I was making - I was using a user-generated
> MAC for my testing rather than choosing a MAC from one of the bridge's
> interfaces.
> 
> So, my question is: why doesn't a user-generated MAC work? On the
> surface, it seems like all devices on the same LAN should have
> different MAC addresses. Yet, with Linux bridging, it appears that (at
> least in certain conditions, like if there is an IP assigned to the
> bridge,) then the bridge *must* share a MAC with one of its
> sub-interfaces in order to function properly. This is very
> counter-intuitive and a mystery to me and probably quite a few other
> bridging newbies (which is why an explanation would make a great
> addition to the Net:Bridge FAQ :)

The problem is that the bridge only thinks a packet is "local" if
it arrives with destination hw addr == incoming device address.
