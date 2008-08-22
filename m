Message-ID: <2e59e6970808212134w2fb50616ib6c80bbddbe75d14@mail.gmail.com>
Date: Fri, 22 Aug 2008 04:34:19 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <CA042BC4B79F1245B9702FA46497D446018F804C@XMBIL133.northgrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <442a305e0808182232r4591c018v1b33b3100d725ac@mail.gmail.com>
	<2e59e6970808210623r2cbf4801j5474f73e5dbc4dce@mail.gmail.com>
	<CA042BC4B79F1245B9702FA46497D446018F804C@XMBIL133.northgrum.com>
Subject: Re: [Bridge] linux bridging problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Brodie, Laura (Mission Systems)" <Laura.Brodie@ngc.com>
Cc: bridge@lists.linux-foundation.org

On Thu, Aug 21, 2008 at 8:39 PM, Brodie, Laura (Mission Systems)
<Laura.Brodie@ngc.com> wrote:
> Help please,
>
> My goal is to create a bridge to do traffic shaping for a subnet.
> I am trying to create a bridge following the Linux Foundation sample
> setup in a VMware CentOS guest OS (before the router) using the
> commands:
>
>        brctl addbr br0
>        brctl addif br0 eth0
>        brctl addif br0 eth1
>        ifconfig eth0 down
>        ifconfig eth1 down
>        ifconfig eth0 0.0.0.0 up
>        ifconfig eth1 0.0.0.0 up
>        ifconfig eth1 192.168.1.167
>
> The problem: A flood of ARP requests from the Vyatta machine
> (10.244.2.19) looking for the DNS Server (10.244.2.1) on the upper
> network shuts down the entire network.

ARP requests are almost never issued in floods.  Most likely you have
a bridging loop duplicating the packets (maybe without reducing TTL)
and multiplying the traffic a thousand-fold.  Consider enabling
spanning tree or break the bridging loop.

Also, you should put IP addresses on the bridge, not the member
interfaces.  Try:

ifconfig eth0 up
ifconfig eth1 up
ifconfig br0 192.168.1.167 up

as your last three entries.

>
> Thanks,
> Laura Lee
