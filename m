Date: Fri, 15 Jun 2007 17:20:38 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Trouble with bridged interfaces
Message-ID: <20070615172038.37973c22@localhost>
In-Reply-To: <63CB92BFF23FC54A8CF2F4A67654B24601F863D7@i-worx-srv-02.i-worx.ca>
References: <20070615092100.5df0c045@localhost>
	<63CB92BFF23FC54A8CF2F4A67654B24601F863D7@i-worx-srv-02.i-worx.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roman Lisagor <RLisagor@wurldtech.com>
Cc: bridge@linux-foundation.org

On Fri, 15 Jun 2007 16:24:56 -0700
"Roman Lisagor" <RLisagor@wurldtech.com> wrote:

> Hi Stephen,
> 
> We are doing this for a network testing product. Our box sits between
> two devices (e.g. one connected to eth0 and one to eth1) which
> communicate with each other, so we bridge the two interfaces to maintain
> communication between the two sides. One of the devices (connected to
> eth0) is under test so we need to send and receive traffic to and from
> that device and want to be sure that none of the _test_ traffic is also
> going to eth1. Raw sockets are used to create the traffic on eth0.
> 
> In most cases this works well, but in some cases (which are very
> difficult to reproduce or determine the pattern for) we see incoming
> packets on the bridge instead of the interface.
> 
> Also, what do you mean when you say that addresses are not assigned to
> interfaces? (Isn't that the result of running "ifconfig ethX
> ip.ip.ip.ip"?)
> 
> Thanks again,
> Roman.
>

A per previous suggestion, use ebtables.  It is the best way
to get selective traffic control or any other hacks.
