Message-ID: <486A48D0.8040102@trash.net>
Date: Tue, 01 Jul 2008 17:10:08 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <486912e7.a6.3013.6700211@webmaildh6.aruba.it>
	<2e59e6970806301542t405646das78baa26f0cda8f6e@mail.gmail.com>
In-Reply-To: <2e59e6970806301542t405646das78baa26f0cda8f6e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] 802.1q packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@linuxfoundation.org, Stephen Hemminger <shemminger@vyatta.com>

richardvoigt@gmail.com wrote:
> On Mon, Jun 30, 2008 at 5:07 PM, Fulvio Ricciardi <
> fulvio.ricciardi@zeroshell.net> wrote:
> 
>>> That mostly rules out other devices in the path as the
>>> cause of the problem.  There's just one chance of a
>>> netfilter interaction that I can think of: netfilter may
>>> cause fragments to be recombined, without netfilter the
>>> fragments could be bridged.  Are you running the ping
>>> command from the bridge itself, or across the bridge? (I
>>> presume across the bridge because you are discussing the
>>> FORWARD chain only)
>> I ping across the bridge. If instead a ping from the bridge
>> itself, all works right.
>>
>>> Do the large ping requests show up in the iptables
>>> counters?
>> Yes, in any case (either ping -s 1472 and ping -s 1473) the
>> packets are counted in the FORWARD chain.
>>
>>> What happens if you set no fragmentation when you run
>>> ping?
>> it's the same
> 
> 
> Just to verify, you mean that with no fragmentation, large pings go through
> if and only if bridge-nf-call-iptables is disabled?


Just FYI for all affected, I'm looking into this. One
problem is that only packets with skb->protocol == ETH_P_IP
are refragmented, but not ETH_P_8021Q. That change alone
doesn't fix it though, still trying to track it down.

