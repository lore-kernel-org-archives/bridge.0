Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bridge] Trouble with bridged interfaces
Date: Fri, 15 Jun 2007 16:24:56 -0700
Message-ID: <63CB92BFF23FC54A8CF2F4A67654B24601F863D7@i-worx-srv-02.i-worx.ca>
In-reply-to: <20070615092100.5df0c045@localhost>
From: "Roman Lisagor" <RLisagor@wurldtech.com>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@linux-foundation.org

Hi Stephen,

We are doing this for a network testing product. Our box sits between
two devices (e.g. one connected to eth0 and one to eth1) which
communicate with each other, so we bridge the two interfaces to maintain
communication between the two sides. One of the devices (connected to
eth0) is under test so we need to send and receive traffic to and from
that device and want to be sure that none of the _test_ traffic is also
going to eth1. Raw sockets are used to create the traffic on eth0.

In most cases this works well, but in some cases (which are very
difficult to reproduce or determine the pattern for) we see incoming
packets on the bridge instead of the interface.

Also, what do you mean when you say that addresses are not assigned to
interfaces? (Isn't that the result of running "ifconfig ethX
ip.ip.ip.ip"?)

Thanks again,
Roman.


-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@linux-foundation.org] 
Sent: Friday, June 15, 2007 9:21 AM
To: Roman Lisagor
Cc: bridge@linux-foundation.org
Subject: Re: [Bridge] Trouble with bridged interfaces

On Wed, 13 Jun 2007 18:28:07 -0700
"Roman Lisagor" <RLisagor@wurldtech.com> wrote:

> Hi,
> 
> We need to bridge several interfaces together, but still retain the
> ability to communicate through the individual interfaces. So for
> example, we have eth0 and eth1 bridged and we bind IP addresses to
both
> of them, in order to inject packets into communication between two
> devices connected to our interfaces.
> 


Addresses in Linux aren't assigned to interfaces.
Look up the regular questions that come up about Linux responding
to ARP on the wrong interface.

> It seems that several problems arise intermittently:
> 
> 1. When sending ping requests, replies sometimes come in on eth0/1,
but
> sometimes on br0. We can work around this, but it would be great to
get
> some idea of why and when this happens (and possibly whether we can
> prevent it from occurring);
> 
> 2. Occasionally, ARP requests sent by external devices for the IPs of
> eth0/1 are ignored.
> 
> We are running Fedora Core 6 (2.6.13-15-smp).
> Any ideas?
>  
> Thanks in advance for your help.
> 
> Roman

Go up your requirements, why do you need to do things this way?
There may be better alternatives

