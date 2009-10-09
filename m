Date: Thu, 8 Oct 2009 23:01:41 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20091008230141.32c57e6e@nehalam>
In-Reply-To: <88ed5400910071322l360fe50cn2986895549f60f82@mail.gmail.com>
References: <88ed5400910071322l360fe50cn2986895549f60f82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Distributed RSTP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: NITIN SS <hi.nitin2000@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Wed, 7 Oct 2009 13:22:44 -0700
NITIN SS <hi.nitin2000@gmail.com> wrote:

> Hi,
> 
> I am new to this RSTP/Bridge group and currently planning on distributed
> RSTP.
> 
> First of all, Distributed RSTP mean as, we will have 8 linux RSTPs and they
> all will have the same Bridge ID.

So you plan to take a perfectly good spec 802.1d and break it.
Why?

> As all bridges will have the same Bridge ID so I need to sync many variables
> functions across all units.

You are off in never-never fantasy land. Stop and ask why are you
doing this? It is like the old joke: "Doctor it hurts when I hit
my head with my fist..."

> Additionally there should be only one root port for all the eight bridges.
> In this way there should be one master which would be maintaing bridge
> variables and controlling bridge operations.
> There is only point to point link between all bridges through master.
> Additioanlly most of the RSTP state machines are port based so it looks
> feasible.
> 
> As your guys are RSTP experts, so i think it would be the right place to get
> suggestions/comments.
> 
> -What would be the limitations/complex Issues?
> -Is it feasible?
>  At top level it looks like there would be lot of efforts with respect to
> final outcome.
> -Is there any implementation of distributed RSTP?
> 
> Appreciate your comments.
> 
> Regards,
> Nitin


-- 
