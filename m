Return-Path: <stephen@networkplumber.org>
Date: Fri, 8 May 2015 09:57:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20150508095702.5f6caf37@urahara>
In-Reply-To: <CAGZFCEHrB5awRa4qaMgwriW_x9qXOMUjG-Nom+aWQ_TWXA040Q@mail.gmail.com>
References: <CAGZFCEHrB5awRa4qaMgwriW_x9qXOMUjG-Nom+aWQ_TWXA040Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] linux brigde query
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: ratheesh kannoth <ratheesh.ksz@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 4 May 2015 15:34:17 +0530
ratheesh kannoth <ratheesh.ksz@gmail.com> wrote:

>              br0
>               |
> --------------------------------------------
>  |                   |                   |
> eth0              eth1             eth2
>  |                                        |
> Machine A                       machine B
> 
> suppose there is a UDP bidirectional traffic between machine A and B.
> Then there will be bridge port
> info in "brctl showmacs br0"  command output. After some time, UDP
> traffic becomes only uni directional( say
> only from machine A to B , there is no traffic from B to A ). Then
> before bridge ages out , B got removed ; but link eth2
> is not going down ( no link down message at eth2, it can be achieved
> if  eth2 to a harware switch , and machine
> was connected to one port of that switch ). Then traffic will flood or
> will black hole till ageing timer expire.

When eth2 is removed or goes down then, all forwarding table
entries related to eth2 are removed. All packets for Ethernet
address of machine B will then be processed according to the
standard flooding model BUM (Broadcast, Unknown, Mulicast_)

This is standard learning switch behavior described in IEEE standard
and lots of text books.

In real world, it is possible that machine B is often re-connected
to another switch (eth1 for example), and this allows transparent
rediscovery.

With recent (like last 2 years) version of Linux switch there
are flags to control allow disabling flooding and learning behavior
which are often used in virtualization environments to control
packet leakage.
