Return-Path: <brouer@redhat.com>
From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <20170831182012.5d321c6a@redhat.com>
In-Reply-To: <a9349049-bfd7-b6c0-d1c7-2f70b0b0ab11@gmail.com>
References: <1504156693-24692-1-git-send-email-roopa@cumulusnetworks.com>
	<20170831143814.68709334@redhat.com>
	<CAJieiUjZ5dTNpBFb8c2KMRgjXRCKVGhJsTfQcpiw+p6fyNVwDw@mail.gmail.com>
	<a9349049-bfd7-b6c0-d1c7-2f70b0b0ab11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: add tracepoint in
	br_fdb_update
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Thu, 31 Aug 2017 16:20:20 -0000
To: David Ahern <dsahern@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, brouer@redhat.com, "davem@davemloft.net" <davem@davemloft.net>

On Thu, 31 Aug 2017 09:30:05 -0600
David Ahern <dsahern@gmail.com> wrote:

> On 8/31/17 9:21 AM, Roopa Prabhu wrote:
> > On Thu, Aug 31, 2017 at 5:38 AM, Jesper Dangaard Brouer
> > <brouer@redhat.com> wrote:  
> >> On Wed, 30 Aug 2017 22:18:13 -0700
> >> Roopa Prabhu <roopa@cumulusnetworks.com> wrote:
> >>  
> >>> From: Roopa Prabhu <roopa@cumulusnetworks.com>
> >>>
> >>> This extends bridge fdb table tracepoints to also cover
> >>> learned fdb entries in the br_fdb_update path. Note that
> >>> unlike other tracepoints I have moved this to when the fdb
> >>> is modified because this is in the datapath and can generate
> >>> a lot of noise in the trace output. br_fdb_update is also called
> >>> from added_by_user context in the NTF_USE case which is already
> >>> traced ..hence the !added_by_user check.
> >>>
> >>> Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
> >>> ---
> >>>  include/trace/events/bridge.h | 31 +++++++++++++++++++++++++++++++
> >>>  net/bridge/br_fdb.c           |  5 ++++-
> >>>  net/core/net-traces.c         |  1 +
> >>>  3 files changed, 36 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/trace/events/bridge.h b/include/trace/events/bridge.h
> >>> index 0f1cde0..1bee3e7 100644
> >>> --- a/include/trace/events/bridge.h
> >>> +++ b/include/trace/events/bridge.h
> >>> @@ -92,6 +92,37 @@ TRACE_EVENT(fdb_delete,
> >>>                 __entry->addr[4], __entry->addr[5], __entry->vid)
> >>>  );
> >>>
> >>> +TRACE_EVENT(br_fdb_update,
> >>> +
> >>> +     TP_PROTO(struct net_bridge *br, struct net_bridge_port *source,
> >>> +              const unsigned char *addr, u16 vid, bool added_by_user),
> >>> +
> >>> +     TP_ARGS(br, source, addr, vid, added_by_user),
> >>> +
> >>> +     TP_STRUCT__entry(
> >>> +             __string(br_dev, br->dev->name)
> >>> +             __string(dev, source->dev->name)  
> >>
> >> I have found that using the device string name is
> >>
> >> (1) slow as it involves strcpy+strlen
> >>
> >>  See [1]+[2] where a single dev-name costed me 16 ns, and the base
> >>  overhead of a bpf attached tracepoint is 25 ns (see [3]).
> >>
> >>  [1] https://git.kernel.org/davem/net-next/c/e7d12ce121a
> >>  [2] https://git.kernel.org/davem/net-next/c/315ec3990ef
> >>  [3] https://git.kernel.org/davem/net-next/c/25d4dae1a64
> >>
> >> (2) strings are also harder to work-with/extract when attaching a bpf_prog
> >>
> >> See the trouble I'm in accessing a dev string here napi:napi_poll here:
> >>  https://github.com/netoptimizer/prototype-kernel/blob/103b955a080/kernel/samples/bpf/napi_monitor_kern.c#L52-L58
> >>
> >> Using ifindex'es in userspace is fairly easy see man if_indextoname(3).
> >>  
> > 
> > Jesper thanks for the data!. GTK. Looking at include/trace/events,
> > currently almost all tracepoints use dev->name.

True, but with my recent experience and benchmarking, I consider this
generally a bad choice we have made for all these tracepoints.  In your
case with 2 strings, 2x16=32ns, you basically introduced a overhead
that is larger that to invocation cost.

> > These bridge tracepoints in context are primarily for debugging fdb
> > updates only, not for every packet and hence not in the performance
> > path.
> > In large scale deployments with thousands of bridge ports and fdb
> > entries, dev->name will definately make it easier to trouble-shoot.
> > So, I did like to leave these with dev->name unless there are strong objections.  
> 
> +1 for user friendliness for debugging tracepoints. The device name is
> also more user friendly when adding filters to the data collection.
>
> Being able to add bpf everywhere certainly changes the game a bit, but
> we should not relinquish ease of use and understanding for the potential
> that someone might want to put a bpf program on the tracepoint and want
> to maintain high performance.

(Cc. Acme and Peterz)
I wonder if we can create a special perf-tracepoint type for ifindex'es
and the tool reading (e.g. perf-script) can perform the name lookup in
userspace (calling if_indextoname(3)) ?

I don't know the perf tools well enough to know if this is possible?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
