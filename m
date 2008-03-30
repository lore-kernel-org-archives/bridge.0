From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
References: <8571495929364495836@unknownmsgid>
	<fed120860803300232v678efc1dr862e5d3ba5fbf16d@mail.gmail.com>
In-Reply-To: <fed120860803300232v678efc1dr862e5d3ba5fbf16d@mail.gmail.com>
Date: Sun, 30 Mar 2008 13:59:15 +0200
Message-ID: <026e01c8925d$79f03ba0$6dd0b2e0$@Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: sv
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
To: "'Srinivas M.A.'" <srinivas.aji@gmail.com>
Cc: Bridge@lists.linux-foundation.org

> -----Original Message-----
> From: Srinivas M.A. [mailto:srinivas.aji@gmail.com]
> Sent: den 30 mars 2008 11:32
> To: Joakim Tjernlund
> Cc: Bridge@lists.linux-foundation.org
> Subject: Re: [Bridge] RSTP in http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git; a=summary
> problems
> 
> This is fairly new code, but it has gone through some testing and use.
> One limitation
> is that there is no mechanism to automatically restart or fall back to
> kernel STP if the RSTP
> daemon crashes. But it hasn't crashed lately in our testing.

Should be fixable, just vfork and wait for an abnormal exit status,
reset state and vfork again.

> 
> Thanks.
> Srinivas.
> 
> P.S.: One note on bridge-stp and general bridge startup.
> 
> We started out with needing an explicit rstpctl command to indicate
> to the daemon that it needs to run RSTP on a bridge, which is why there is the
> "exec /sbin/rstpctl rstp $bridge on ;;" (as you corrected in your patch.)
> 
> But now, the daemon is written to enable RSTP when it finds that the
> kernel is treating the
> bridge as RSTP (/sys/class/net/<bridge_name>/bridge/stp_state is 2),

hmm, how does stp_state become 2? Do I need a new kernel(on 2.6.23 now)?

> so as long as you run
> "brctl stp <bridge_name> on" before briding the bridge interface up,
> you can just have a
> bridge-stp script that returns 0 (success) when you want rstpd to
> handle the bridge, and
> non-zero when you want kernel STP running on the bridge.
> 
> That startup sequence we use is:
> 0. Have a bridge-stp that returns 0 if you want RSTP for the
> particular bridge name.
>     Or returns 0 always if you intend to have only one bridge, and want RSTP.

Don't follow, why do I need a bridge-stp at all? Seem like I should
just start rstpd and config my bridge normally?

> 
> 1. Start rstpd
> 2. Configure the bridge (brctl addbr, brctl addif's ...)
> 3. brctl stp <bridge_name> on
> 4. ifconfig <bridge_name> up. (Or ifup <bridge_name>, which should
> apply any IP config.)


