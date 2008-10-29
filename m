Message-ID: <2e59e6970810290619n53f66084gf8c156368eab05c@mail.gmail.com>
Date: Wed, 29 Oct 2008 13:19:34 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <490762EE.9000605@kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <490762EE.9000605@kth.se>
Subject: Re: [Bridge] Bridge with a tweak...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Mattias Kjellsson <mkje@kth.se>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On Tue, Oct 28, 2008 at 7:07 PM, Mattias Kjellsson <mkje@kth.se> wrote:
> Hi list,
>
> I have a question regarding bridges in general, and my bridge in
> particular. I want to take all the packages flowing one way over the
> bridge (say eth0->eth1) and pack them in my own packet- structure (extra
> headers added, and the content modulated for further wireless
> transportation), and all the packages flowing in the other direction
> (say eth1->eth0) needs to be "de- packed" (stripped of my custom
> headers, and demodulated).
>
> What I'm basically doing is trying to make my software radio (connected
> to one of the network- devices) work as a wireless network adapter, but
> with my own signaling- scheme, but I don't want to use the same computer
> for the radio, as for "browsing the web", since the radio- part is a bit
> on the heavy side to the processor.
>
> Is there an easy way to do this? Where would you start? I have been
> looking at the code for the kernel- module, but haven't really got any
> really useful clues from it.
>
> Any pointers towards where to start looking, poking and dragging would
> be greatly appreciated.

Yes... you modify the particular interface, not the bridge.  For
example, you can place a tun/tap interface into the bridge (instead of
eth1) to receive all packets passing through the bridge into a
user-mode application.  If you get the user-mode solution fully
working but the performance is not high enough, then you could make a
kernel module.  And the vlan or IP tunneling code would be the best
place to start, since they add and remove headers already.  But
user-mode is much easier both to write and to debug, so start with
tun/tap.

Note that because of the switching code, you'll not get any packets
arriving on your interface besides ARP until you get bidirectional
communications working (well, maybe some broadcast UDP like DHCP
REQUEST).

>
> BR
> Mattias Kjellsson
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
