From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <fed120860803310025p33efd12ds6cbba5d0f978caf5@mail.gmail.com>
References: <8571495929364495836@unknownmsgid>
	<fed120860803300232v678efc1dr862e5d3ba5fbf16d@mail.gmail.com>
	<7423344835968003573@unknownmsgid>
	<fed120860803301213r6f1e1aadwf26d269a4224b768@mail.gmail.com>
	<1206911933.7589.426.camel@gentoo-jocke.transmode.se>
	<fed120860803310025p33efd12ds6cbba5d0f978caf5@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Mar 2008 09:44:18 +0200
Message-Id: <1206949458.7589.447.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Subject: Re: [Bridge] RSTP
	in	http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
	a=summary	problems
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Srinivas M.A." <srinivas.aji@gmail.com>
Cc: Bridge@lists.linux-foundation.org


On Mon, 2008-03-31 at 12:55 +0530, Srinivas M.A. wrote:
> >
> >  Ahh, I didn't copy bridge-stp to /sbin because I didn't think it was
> >  needed. Just to test I blindly copied it to /sbin and did:
> >   brclt addbr br0
> >
> >  brctl addif br0 eth0
> >   brctl stp br0
> >  and it hung my board :(
> 
> What did your /sbin/bridge-stp have. The file from the tarball? Try a
> simple one which just does exit 0.

Yes, form the tarball. Now I have replace it with a
  #!/bin/bash
  exit 0
and now it works(well it starts and activates RSTP) :)
So something isn't well with the included bridge-stp and
you can hang your system too.

Just for fun I tried what would happen if i never started rstpd,
then I get:

strace ./rstpctl showbridge
....
open("/dev/urandom", O_RDONLY)          = 3
read(3, "@\336\316\223", 4)             = 4
close(3)                                = 0
socket(PF_FILE, SOCK_DGRAM, 0)          = 3
getpid()                                = 245
bind(3, {sa_family=AF_FILE, path=@RSTPCTL_245}, 110) = 0
connect(3, {sa_family=AF_FILE, path=@.rstp_server}, 110) = -1
ECONNREFUSED (Connection refused)
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++
Process 245 detached
root@192.168.1.16:~# m /sys/class/net/br0/bridge/stp_state
2

So I both get a SEGV and the kernel thinks userspace is running STP, not
ideal.

I really think one should be able to start RSTP with rtspctl too so
one doesn't need /sbin/bridge-stp

> 
> >  Meanwhile I got 2 patches for you:
> >
> 
> I didn't realize offsetof() was in stddef.h. Thanks.

I you want, you can remove the #ifndef too, gcc 3.4.6 has offsetof in
stddef.h

> 
> The __builtin_choose_expr stuff is there to trigger a compiler error
> if I try to compare or copy two structs of different sizes. I should
> just make that portion dependent on having a new enough gcc.

I removed it because I don't like having gcc extension in the code,
makes it dependend on gcc and harder to understand. gcc 3.4.6 can handle
this builtin fine.

 Jocke
