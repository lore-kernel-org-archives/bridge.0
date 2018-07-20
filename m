Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=Aa0++ugjUwY5vmuDD9y2ZS9OiFZIFbozJDfQ5RU4tEc=;
	b=bKNoE3fdznqMBr0LQpO6spsrOVrDweSwmE7INpECkGuRxK6+Zuv6drln2B/VYScsDh
	fG3F1PMfJKVj6UNJM34+iYJ2G9U23ezxzYWMS2xaH/pe1ZUybirFw22+20rehpW/TlK1
	vcMP5EDcppengBCZWnosa1bJodr+58ae8S8xU=
MIME-Version: 1.0
In-Reply-To: <20180720090259.751a82f4@xeon-e3>
References: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
	<20180720144826.29892-3-nikolay@cumulusnetworks.com>
	<20180720090259.751a82f4@xeon-e3>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Fri, 20 Jul 2018 09:41:37 -0700
Message-ID: <CAJieiUikHsmGLnSv5dEc0POqmC2UbKZ4YpzSXd=Bkbd-vtNgQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net-next 2/2] net: bridge: add support for
	backup port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Wilson Kok <wkok@cumulusnetworks.com>, Anuradha Karuppiah <anuradhak@cumulusnetworks.com>, David Miller <davem@davemloft.net>

On Fri, Jul 20, 2018 at 9:02 AM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Fri, 20 Jul 2018 17:48:26 +0300
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
>
>> This patch adds a new port attribute - IFLA_BRPORT_BACKUP_PORT, which
>> allows to set a backup port to be used for known unicast traffic if the
>> port has gone carrier down. The backup pointer is rcu protected and set
>> only under RTNL, a counter is maintained so when deleting a port we know
>> how many other ports reference it as a backup and we remove it from all.
>> Also the pointer is in the first cache line which is hot at the time of
>> the check and thus in the common case we only add one more test.
>> The backup port will be used only for the non-flooding case since
>> it's a part of the bridge and the flooded packets will be forwarded to it
>> anyway. To remove the forwarding just send a 0/non-existing backup port.
>> This is used to avoid numerous scalability problems when using MLAG most
>> notably if we have thousands of fdbs one would need to change all of them
>> on port carrier going down which takes too long and causes a storm of fdb
>> notifications (and again when the port comes back up). In a Multi-chassis
>> Link Aggregation setup usually hosts are connected to two different
>> switches which act as a single logical switch. Those switches usually have
>> a control and backup link between them called peerlink which might be used
>> for communication in case a host loses connectivity to one of them.
>> We need a fast way to failover in case a host port goes down and currently
>> none of the solutions (like bond) cannot fulfill the requirements because
>> the participating ports are actually the "master" devices and must have the
>> same peerlink as their backup interface and at the same time all of them
>> must participate in the bridge device. As Roopa noted it's normal practice
>> in routing called fast re-route where a precalculated backup path is used
>> when the main one is down.
>> Another use case of this is with EVPN, having a single vxlan device which
>> is backup of every port. Due to the nature of master devices it's not
>> currently possible to use one device as a backup for many and still have
>> all of them participate in the bridge (which is master itself).
>> More detailed information about MLAG is available at the link below.
>> https://docs.cumulusnetworks.com/display/DOCS/Multi-Chassis+Link+Aggregation+-+MLAG
>>
>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>
> Trying to understand this.
>
> Is it the case that what you are trying to solve is the way MLAG
> and bridging interact on the Linux side or more a limitation of how
> switches operate?  Wouldn't this work?

not a limitation. Its the way MLAG works on the switch side

>
>                 br0 -- team0 -- eth1
>                              +- eth2
>
> The bridge would only have fdb entries for the team device.
> Why do eth1 and eth2 have to be master devices?  Why would eth1
> and eth2 need to be bridge ports.


Two switches acting in a MLAG pair are connected by the peerlink
interface which is a bridge port.

the config on one of the switches looks like the below. The other
switch also has a similar config.
eth0 is connected to one port on the server. And the server is
connected to both switches.


br0 -- team0---eth0
      |
      -- switch-peerlink

switch-peerlink becomes the failover/backport port when say team0 to
the server goes down.
Today, when team0 goes down, control plane has to withdraw all the fdb
entries pointing to team0
and re-install the fdb entries pointing to switch-peerlink...and
restore the fdb entries when team0 comes back up again.
and  this is the problem we are trying to solve.

This also becomes necessary when multihoming is implemented by a
standard like E-VPN https://tools.ietf.org/html/rfc8365#section-8
where the 'switch-peerlink' is an overlay vxlan port (like nikolay
mentions in his patch commit). In these implementations, the fdb scale
can be much larger.

On why bond failover cannot be used here ?: the point that nikolay was
alluding to is, switch-peerlink in the above example is a bridge port
and is a failover/backport port for more than one or all ports in the
bridge br0. And you cannot enslave switch-peerlink into a second level
team
with other bridge ports. Hence a multi layered team device is not an
option (FWIW, switch-peerlink is also a teamed interface to the peer
switch).

We have also discussed trying to achieve this by creating a fdb dst
failover group at the fdb layer instead of the port layer...for faster
fwding failover.
But nikolay soon recognized that this gets more complicated with
learning etc. Hence this patch keeps it simple and adds it at the port
layer.


>
> This kind of thing in the bridge is most likely inevitable, and
> I am guilty of introducing same logic into Hyper-V driver.
> But still getting pushback that the multi device model is better.
>
