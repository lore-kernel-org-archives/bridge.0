Date: Fri, 4 Nov 2005 09:26:54 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge question
Message-ID: <20051104092654.417b4ce6@dxpl.pdx.osdl.net>
In-Reply-To: <30be90270511040519o45d1dd0dr73834b6424dbe62@mail.gmail.com>
References: <DE026503646E7F40AF97BAB98334333BF0C972@uss-republic.finepoint.com>
	<30be90270511031517v3bbbafcfr2a46adaa18cb90d9@mail.gmail.com>
	<436AA439.7050207@candelatech.com>
	<30be90270511040519o45d1dd0dr73834b6424dbe62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Hai Wang <u2.ireland@gmail.com>
Cc: Ben Greear <greearb@candelatech.com>, bridge@lists.osdl.org

On Fri, 4 Nov 2005 08:19:35 -0500
Hai Wang <u2.ireland@gmail.com> wrote:

> Stephen,
>   Since your trick is using 2 (even 4) priority bits, do you think it could
> cause some cmpatibility issue with other STP implementation which still uses
> these bits? (it seems to me that port priority is local significant. maybe
> we can use all 8 bits for port ID, can't we?)
>   If we take other approaches, like create more than one bridges on one
> Linux box, I am not sure if it is feasible, since I saw all bridges created
> on the box have the same bridge ID.
>   Thanks!

The port id is treated as a 16 bit ordered field by STP. So the other
side won't have any problem. Nested bridge's won't work for a bunch of
implementation related reasons, it's not impossible to change to allow
that just a lot of work getting rid of all the possible race issues.

The bridge id comes from the Mac of the first interface in bridge.
So if you have mulitple bridges they all would have different bridge ids.


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
