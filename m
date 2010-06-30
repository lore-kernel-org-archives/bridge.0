MIME-Version: 1.0
In-Reply-To: <AANLkTil_htjsbpP4oz318heSGIU-1_Atrcgx9uLoOjpR@mail.gmail.com>
References: <AANLkTil_htjsbpP4oz318heSGIU-1_Atrcgx9uLoOjpR@mail.gmail.com>
Date: Wed, 30 Jun 2010 09:15:54 -0500
Message-ID: <AANLkTinpKmxk1HmjFOimuJgRXqIM71shpEMg_NVBDLsk@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] What are actually ethernet devices (and what does a
	bridge do?).
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stef Bon <stefbon@gmail.com>
Cc: bridge@lists.linux-foundation.org

The host processor which does the bridging, can also act as a node
sending and receiving traffic to the bridged network.  What you see as
the "IP address of the bridge" is actually the configuration of the
interface representing this connection to the host processor.

Packets generated on the bridge host use this IP address as the source
address, packets sent to this IP address are processed locally on the
bridge host and not forwarded.

On Wed, Jun 30, 2010 at 4:37 AM, Stef Bon <stefbon@gmail.com> wrote:
> Hello,
>
> I'm trying to set up bridged interfaces for my LinuxFromScratch
> machine, to make it possible to run virtual machines
> which should have direct access to the network.
>
> The way to do is to use a bridge, which allows to attach more than one
> (virtual) device to a (physical) device.
>
> Now when reading on the internet all about sollutions to to that,
> there are a lot, and I am losing the oversight:
> do not see the wood through the trees like we use to say in Holland.
>
> Now what strikes me first is that in a lot of cases a bridge is
> getting an ip address, which is (I think) not right.
> An bridge connects connects devices, and these devices should get the
> ip address, not the bridge self!
>
> Looking futher at what an ethernet device is (in Linux), is that it
> actually two things at the same time. When
> making the Linux host set up the network ethernet devices, it does two
> things: bring up the hardware link with
>
> ip link set eth0 up
>
> (when the ethernet device is eth0)
>
> This command is doing something in what is defined in the OSI model as
> physical layer.
>
> When success, the device is assigned an ip address, in my case an ipv4 address:
>
> ip addr add 192.168.0.13/255.255.255.0 dev eth0
>
> This has only meaning in another layer, I'm not sure which, probably
> the Network Layer.
> On my system this operation is called service ipv4-static.
>
> Its working on the eth0 interface which happens to have the same name
> as the hardware link.
>
> I'm only thinking out loud, please correct me if I'm on the wrong track.
>
> So it's good to know this command is doing something in that layer.
>
> So what does a bridge do when chaining a virtual device to an physical device?
> It creates an interface in the network layer, and linking it to an
> existing physical device.
>
> Now every service, like the assigning of an ipv4 address, is possible
> on the virtual device.
>
> So again, I do not understand why the bridge self is getting an ip
> address. It's a network device
> to connect other devices to, replacing the original phyical device.
>
> It does exist in the network layer, and not in the hardware layer.
>
> Does my analysis make sense?
>
> Stef
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
