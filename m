In-Reply-To: <2e59e6971003251003g34f45ccsf7feecbcb2d68cbf@mail.gmail.com>
References: <OFB9EFBBE7.11608167-ONC12576F1.005B0C79-C12576F1.005BBE51@transmode.se>
	<2e59e6971003251003g34f45ccsf7feecbcb2d68cbf@mail.gmail.com>
Message-ID: <OF55692ECA.4BA1B52C-ONC12576F1.006BA68C-C12576F1.007010C8@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 25 Mar 2010 21:24:03 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] IP address on physcial interface instead of bridge
	interface?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@lists.linux-foundation.org

"richardvoigt@gmail.com" <richardvoigt@gmail.com> wrote on 2010/03/25 18:03:34:
>
> On Thu, Mar 25, 2010 at 11:42 AM, Joakim Tjernlund
> <joakim.tjernlund@transmode.se> wrote:
> >
> > Currently it isn't possible to to have an IP address on one of interfaces
> > attached to a bridge, one must always put the IP address on the bridge
> interface itself.
> >
> > I wonder if there is a technical reason for that? I would love to be able
> > to be able to chose any ONE interface attached to the bridge.
> > Example:
> > Assume br0 bridge with two interfaces attached, eth0 and eth1.
> > Then I would like to assign the IP address to eth0 instead of
> > br0. Ideally one should be able to just attach eth0 with an existing IP address
> > to br0.
>
> Migrating existing configuration to the bridge at the time a port is
> added (and back to one member when the bridge is dissolved) has been
> discussed quite a bit recently, and is completely different from
> trying to independently configure L3 state of bridge ports at
> arbitrary times.

Sorry but I could not find that discussion but it doesn't sound as
what I was after. Basically I want the eth0 I/F keeping its IP address
and take over the roll of the br0 I/F when it has an IP address.

 Jocke

