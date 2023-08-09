Return-Path: <linus.luessing@c0d3.blue>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95521417A9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABA5441711
Date: Thu, 10 Aug 2023 00:56:50 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <ZNQZsl9YZXeCc7cf@sellars>
References: <ZNGMVUNsZWWUd7so@sellars> <20230807182051.47d4d613@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230807182051.47d4d613@hermes.local>
Subject: Re: [Bridge] Getting + maintaining a consistent MDB view in
 userspace?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On Mon, Aug 07, 2023 at 06:20:51PM -0700, Stephen Hemminger wrote:
> Same issue as dumping routing table which routing daemons deal with.
> Most applications end up with two netlink sockets, one for monitor
> and one for dumping.
> 
> You really can't do it from the bridge utility, need to build your
> own tools.

Thanks for the reply, ok.

For the old MLDv1/IGMPv2 output when having
"multicast_mld_version" set to 1 the output of "bridge mdb show"
and "bridge monitor mdb" looks quite straightforward. And I can
piece something together with that (or its netlink messages underneath).
And I see symmetrical netlink events for additions and deletions.

When setting a bridge's "multicast_mld_version" to 2 it looks to me like
there is quite a bit of redundancy in both "bridge mdb show"
and "bridge monitor mdb" output. And addition and deletion notifications
don't look that symmetric to me then anymore. There doesn't
happen to exist some documentation about these (netlink specific)
additions that came with the IGMPv3/MLDv2 implementation, or does
it?

Also, are there tools people can recommend for Linux to test SSM
with various kinds of include/exclude settings?
The only tool I found for SSM so far is mcjoin:
https://github.com/troglobit/mcjoin
But it does not seem to support SSM in exclude mode yet.


The reason I'm interested in this is I'm currently experimenting
with creating proxied IGMP/MLD behaviour between bridge ports,
setup from a daemon in userspace. Which utilizes dummy network interfaces
and tc and is supposed to replicate multicast listeners.
Very early prototype: https://github.com/T-X/brmldproxy/tree/main
