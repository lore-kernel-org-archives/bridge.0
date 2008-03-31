Message-ID: <fed120860803310025p33efd12ds6cbba5d0f978caf5@mail.gmail.com>
Date: Mon, 31 Mar 2008 12:55:24 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <1206911933.7589.426.camel@gentoo-jocke.transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8571495929364495836@unknownmsgid>
	<fed120860803300232v678efc1dr862e5d3ba5fbf16d@mail.gmail.com>
	<7423344835968003573@unknownmsgid>
	<fed120860803301213r6f1e1aadwf26d269a4224b768@mail.gmail.com>
	<1206911933.7589.426.camel@gentoo-jocke.transmode.se>
Subject: Re: [Bridge] RSTP in
	http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
	a=summary problems
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: joakim.tjernlund@transmode.se
Cc: Bridge@lists.linux-foundation.org

>
>  Ahh, I didn't copy bridge-stp to /sbin because I didn't think it was
>  needed. Just to test I blindly copied it to /sbin and did:
>   brclt addbr br0
>
>  brctl addif br0 eth0
>   brctl stp br0
>  and it hung my board :(

What did your /sbin/bridge-stp have. The file from the tarball? Try a
simple one which just does exit 0.

>  Meanwhile I got 2 patches for you:
>

I didn't realize offsetof() was in stddef.h. Thanks.

The __builtin_choose_expr stuff is there to trigger a compiler error
if I try to compare or copy two structs of different sizes. I should
just make that portion dependent on having a new enough gcc.
