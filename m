Message-ID: <fed120860811100228x3fbff600l4e672635d4c260e3@mail.gmail.com>
Date: Mon, 10 Nov 2008 15:58:05 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <BLU149-W2552C09A3C56CF923B077E8B1A0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY119-W404011B5F297F6E9D47DAA8B180@phx.gbl>
	<fed120860811081044k52dbd99fs174d10cd2df33d34@mail.gmail.com>
	<BLU149-W2552C09A3C56CF923B077E8B1A0@phx.gbl>
Subject: Re: [Bridge] Modifying All Packets passing through the bridge!
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Fahim Akhter <akhter.fahim@hotmail.com>
Cc: bridge@lists.linux-foundation.org

On Mon, Nov 10, 2008 at 11:57 AM, Fahim Akhter <akhter.fahim@hotmail.com> wrote:
> The Link
> https://lists.linux-foundation.org/pipermail/bridge/2008-October/006074.html
> , is about capturing packets and sending to user space. Speed is important
> in my current scenario. Is there anyway I can do everything in kernel
> specially by hacking or tweaking the already kernel space. Instead of socket
> programming and capturing packets at ethernet?

That message also talks about the case where userspace will not give
you enough performance. The thing to do then would be to write a
network driver which sits on top of a real network device and
processes the packets before passing it on in either direction. Look
for the vlan and bonding drivers for examples. Or maybe you could use
the netfilter hooks in bridging, if your use of this encrypted link is
restricted to being between bridges.
