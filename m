In-Reply-To: <20090610074542.39f713eb@nehalam>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
Message-ID: <OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 10 Jun 2009 17:32:06 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] RFC: Simple Private VLAN impl.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org

Stephen Hemminger <shemminger@vyatta.com> wrote on 10/06/2009 16:45:42:
>
> On Wed, 10 Jun 2009 15:32:06 +0200
> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>
> >
> > Even though some folks on this list thinks ebtables should be used
> > to deploy Private VLAN I find using ebtables a bit clumsy.
> >
>
> I prefer ebtables be used to "patch" bridge to do these kind
> of special case things.  Remember any code that is put in mainline
> adds additional API's and long term support burden.

I am not sure this is so special anymore. I know that this
adds "support burden" but so does a lot of stuff in the kernel.

Have anybody managed to do Private VLAN with several switches by
just using ebtables? Seems like most people here thinks that
ebtables is the right tool but none has provided any examples
on how to do it so I am starting to think that noone is so the
claim to just use ebtables might be false.

 Jocke

