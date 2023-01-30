Return-Path: <SRS0=sOnO=53=goodmis.org=rostedt@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4A0942D18
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8386142D9B
Date: Mon, 30 Jan 2023 18:23:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20230130182316.53d787ac@gandalf.local.home>
In-Reply-To: <87ilgof20x.fsf@nvidia.com>
References: <cover.1674752051.git.petrm@nvidia.com>
 <ed2e2e305dd49423745b62c0152a0b85bc84a767.1674752051.git.petrm@nvidia.com>
 <20230126125344.1b7b34e2@gandalf.local.home>
 <87ilgof20x.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 06/16] net: bridge: Add a tracepoint
 for MDB overflows
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org

On Mon, 30 Jan 2023 16:50:32 +0100
Petr Machata <petrm@nvidia.com> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > On Thu, 26 Jan 2023 18:01:14 +0100
> > Petr Machata <petrm@nvidia.com> wrote:
> >  
> >> +	TP_printk("dev %s af %u src %pI4/%pI6c grp %pI4/%pI6c/%pM vid %u",
> >> +		  __get_str(dev), __entry->af, __entry->src4, __entry->src6,
> >> +		  __entry->grp4, __entry->grp6, __entry->grpmac, __entry->vid)  
> >
> > And just have: 
> >
> > 	TP_printk("dev %s af %u src %pI6c grp %pI6c/%pM vid %u",
> > 		  __get_str(dev), __entry->af, __entry->src, __entry->grp,
> > 		  __entry->grpmac, __entry->vid)
> >
> > As the %pI6c should detect that it's a ipv4 address and show that.  
> 
> This means the IP addresses will always be IPv6, even for an IPv4 MDB
> entries. One can still figure out the true protocol from the address
> family field, but it might not be obvious. Plus the IPv4-mapped IPv6
> addresses are not really formatted as IPv4, though yeah, IPv4 notation
> is embedded in that.
> 
> All the information is still there, but... scrambled? Not sure the
> reduction in clarity is worth the 8 bytes that we save. The tracepoint
> is unlikely to trigger often.

8 bytes per event, and yes, ring buffer real estate is expensive.

And if you use trace-cmd or perf, we can always add a plugin to
libtraceevent that can format this much nicer based on the information that
is there.

-- Steve
