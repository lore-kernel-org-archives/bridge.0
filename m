Return-Path: <linus.luessing@c0d3.blue>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42DB7401C7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88EE5401C1
Date: Thu, 10 Aug 2023 04:07:17 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <ZNRGVfk0vAYYlfVU@sellars>
References: <ZNGMVUNsZWWUd7so@sellars> <20230807182051.47d4d613@hermes.local>
 <ZNQZsl9YZXeCc7cf@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNQZsl9YZXeCc7cf@sellars>
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

On Thu, Aug 10, 2023 at 12:56:50AM +0200, Linus Lüssing wrote:
> [...]
> When setting a bridge's "multicast_mld_version" to 2 it looks to me like
> there is quite a bit of redundancy in both "bridge mdb show"
> and "bridge monitor mdb" output. And addition and deletion notifications
> don't look that symmetric to me then anymore. There doesn't
> happen to exist some documentation about these (netlink specific)
> additions that came with the IGMPv3/MLDv2 implementation, or does
> it?

And just a few examples which confuse me a bit:

1) ASM, single listener:

$ ./mcjoin -d -i veth0 "[ff12::125]

bridge monitor mdb:

```
dev br0 port veth1 grp ff12::125 temp filter_mode include proto kernel
dev br0 port veth1 grp ff12::125 temp filter_mode exclude proto kernel
```

-> first line seems to be superfluous / no-op?
   Can I always ignore such an event with:
   "n->nlmsg_type == RTM_NEWMDB && mode == MCAST_INCLUDE &&
    !tb[MDBA_MDB_EATTR_SOURCE] && !tb[MDBA_MDB_EATTR_SRC_LIST]" ?

Leave only creates one event:

$ kill <mcjoin ...>

```
Deleted dev br0 port veth1 grp ff12::125 temp filter_mode include proto kernel
```

2) SSM, two listeners:

$ ./mcjoin -d -i veth0 "[fe80::130],[ff12::130]"

```
dev br0 port veth1 grp ff12::130 temp filter_mode include proto kernel
dev br0 port veth1 grp ff12::130 src fe80::130 temp filter_mode include proto kernel
dev br0 port veth1 grp ff12::130 temp filter_mode include source_list fe80::130/260.00 proto kernel
```

-> again first line superfluous / no-op?
   and second + third line identical?

Adding a second join:

$ ./mcjoin -d -i veth0 "[fe80::131],[ff12::130]"

```
dev br0 port veth1 grp ff12::130 src fe80::131 temp filter_mode include proto kernel
dev br0 port veth1 grp ff12::130 temp filter_mode include source_list fe80::131/260.00,fe80::130/247.86 proto kernel
```

-> so looks like the source_list line is actually always a (superfluous /
   redundant?) summary of all sources for this group+port?

And deleting here creates three events:

$ kill <mcjoin -d -i veth0 "[fe80::131],[ff12::130]">

```
Deleted dev br0 port veth1 grp ff12::130 src fe80::131 temp filter_mode include proto kernel
```

$ kill <mcjoin -d -i veth0 "[fe80::130],[ff12::130]">

```
Deleted dev br0 port veth1 grp ff12::130 src fe80::130 temp filter_mode include proto kernel
Deleted dev br0 port veth1 grp ff12::130 temp filter_mode include proto kernel
```

And here the last line seems to be superfluous / redundant?
And the behaviour seems to differ from 1) / ASM, where
I would always only get one event when leaving?


----------

So this currently confuses me a bit regarding which of these netlink
notifications I might be able to ignore safely and which not. And
how to interpret them, which ones are supposed to be a singular update
I would need to add and which ones are supposed to be summaries
that are supposed to potentially update/replace multiple entries.

Regards, Linus
