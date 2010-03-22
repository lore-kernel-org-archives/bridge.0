MIME-Version: 1.0
In-Reply-To: <DBDEC20E6E29304D8AE5EAA493609B3556AE2C7F28@EMBX02-HQ.jnpr.net>
References: <DBDEC20E6E29304D8AE5EAA493609B3556AE2C7F28@EMBX02-HQ.jnpr.net>
Date: Mon, 22 Mar 2010 14:23:29 -0500
Message-ID: <2e59e6971003221223v3b8ff6b9l1e3b1092ec26c15e@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] bridge and ip addresses on enslaved interfaces
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Shawn Delaney <sdelaney@juniper.net>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On Mon, Mar 22, 2010 at 1:58 PM, Shawn Delaney <sdelaney@juniper.net> wrote=
:
> In the documentation I=E2=80=99ve seen so far a bridge is created with no=
 IP address
> for its enslaved interfaces and optionally with an IP address on the brid=
ge
> interface. For example, I create a bridge like so:
>
>
>
> brctl addbr br0
>
> brctl addif br0 eth0
>
> brctl addif br0 eth1



AFAIK, after this packets no longer arrive on the eth0 and eth1
logical interfaces.  Incoming packets have a receive interface of br0
(and which bridge port is stored for physdev-in matching).

>
>
>
> ifconfig eth0 0.0.0.0
>
> ifconfig eth1 0.0.0.0
>
> ifconfig br0 10.0.0.10 netmask 255.255.0.0
>
>
>
>
>
> This works fine. However if I do the following:
>
>
>
> ifconfig eth0 10.0.0.10 netmask 255.255.0.0
>
> ifconfig eth1 10.1.0.10 netmask 255.255.0.0
>
> ifconfig br0 0.0.0.0
>
>
>
> the bridge gets created but I can=E2=80=99t ping the IP addresses of the =
enslaved
> interfaces. With the above configuration I am assuming that the enslaved
> interfaces still behave independently of the bridge, can be assigned IP
> addresses and participate in routes. My question is whether this is
> supported and if I should expect it to work. If so, can someone point me =
to
> an example?
>
>
>
> Thanks.
>
>
>
>
>
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
