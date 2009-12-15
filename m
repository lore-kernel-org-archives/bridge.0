MIME-Version: 1.0
Date: Tue, 15 Dec 2009 12:06:58 -0600
Message-ID: <2e59e6970912151006v2d8c1b34ua34aff0a6a66c16c@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] Re :Re:  Bridging partially (rx eth0 -> tx eth1)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jhautbois@gmail.com
Cc: bridge@lists.linux-foundation.org

On Tue, Dec 15, 2009 at 10:36 AM,  <jhautbois@gmail.com> wrote:
>> ebtables can select which traffic gets bridged.
>>
> Thnks you for answering.
> AFAIK, ebtables works like iptables, but within the L2 layer ?
> This means I could eventually send only IP (and VLAN) traffic to the host,
> and forward everything else ?

Yes, or you can match based on input interface, which solves your
original problem if you rephrase the question "how can I bridge all
packets coming in from eth0 and none coming in from eth1?"

>
> I am still looking at the doc.

look at the -i and --physdev-in options

>
> JM
