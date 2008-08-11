Date: Mon, 11 Aug 2008 16:31:59 -0700
From: Stephen Hemminger <stephen.hemminger@vyatta.com>
Message-ID: <20080811163159.49cf9980@extreme>
In-Reply-To: <48A0B4AD.6030703@free.fr>
References: <48A0B4AD.6030703@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] frame destinated to individual port MAC address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benoit PAPILLAULT <benoit.papillault@free.fr>
Cc: Bridge@lists.linux-foundation.org

On Mon, 11 Aug 2008 23:52:45 +0200
Benoit PAPILLAULT <benoit.papillault@free.fr> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi there,
> 
> I'm working on very strange stuff using linux kernel bridge. Anyway, I
> have a quick question.
> 
> Let's say I have 2 linux machines. Each has one bridge with several
> interfaces. One interface of the first bridge (say eth0) is connected to
> one interface of the other bridge (say eth0 again) using an Ethernet cable.
> 
> I have not configured an IP address on the bridge itself (on purpose)
> but on each individual interface in the bridge. In order to be able to
> communicate with those interfaces, I use ebtable broute rules in order
> for the frame entering the bridge and with destination address being the
> individual interface to be routed (-j DROP). Examples:
> 
> ebtables -t broute -L
> Bridge table: broute
> 
> Bridge chain: BROUTING, entries: 4, policy: ACCEPT
> - -d 0:ff:7f:dc:d3:4d -j DROP
> - -d 0:ff:5e:7e:a5:ac -j DROP
> - -d 0:ff:22:84:70:19 -j DROP
> - -d 0:ff:2:fb:4:6d -j DROP
> 
> This is working as expected. So far, so good.
> 
> Now, using rtnetlink, I changed the port state (alternating between
> learning and forwarding). In the learning state, ping is no longer
> working between the 2 nodes. I would expect for the ping to be still
> working (since IMHO bridge itself and its port should not be subject to
> the bridge filtering rules).
> 
> Disclaimer : I'm not saying that the current linux implementation is
> wrong, nor 802.1d is wrong.
> 
> Questions are :
> - - according to 802.1d, what should happen to a frame with a destination
> address being the MAC addr of a bridge port when it enters this bridge
> port? Maybe this is outside of the scope of 802.1d since this frame is
> not going to be "forwarded" in any way.
> 
> - - according to the current linux implementation, would it be a problem
> to accept such frame? I tried a quick patch and it seems to be working.
> However, it probably broke lots of other things.
>

You are doing things in a very non-standard way by putting IP addresses
on each interface. This then leads to problems.  Don't do it.

If port is not forwarding, it needs to ignore the frame to prevent routing
loops. 

Rather than an ask a detailed question like "what will happen if I misconfigure
the system, then change the behaviour", instead start a discussion about
your requirements. Like "I need to forward only frames from some MAC addresses
in a firewall".  The answer might not involve bridging at all...
