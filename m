Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=6L7VisKfM2SZAOZ0g9ig341ENO/lDM1R+0IgxXfxXDA=;
 b=n2BXlYwAVa8WyPpIgBQo7gavGbxQ6h8F9rZDki/38iZUUjXzPnYh9wZ0igKvtPU7fn
 CBcXYAzbE+rR+WKLLE//dKJCR6kKwAMbQWv4X2anXI9bwwn6Gliai7uNqBSvm/RLuOqo
 FPYT4xgGqn+r6byy0z99+HHNaU3KfWQNFGBr4RfcNUKsZ3bzfo8/sRgkc1kEpMxGlkF+
 4juyu3jetJ900ZYGO0uX+Uq1C1Lrad4QzqFLJq5uXO8aWHsPq2S7wPhr51+bbvDkQ5VF
 URkSTmMldzaIflTHMzXQ1uyc3KzLx0UdFBT2QgnsluRVmTjPVVLnUtrHKXyt7ueLytS+
 4uGg==
Message-ID: <d96c9611-f4b8-6c68-8a88-8d8deafdf089@blackwall.org>
Date: Mon, 11 Apr 2022 11:53:52 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220409105857.803667-1-razor@blackwall.org>
 <YlPdFS//hYbBSAkT@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <YlPdFS//hYbBSAkT@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/6] net: bridge: add flush filtering
	support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com

On 11/04/2022 10:47, Ido Schimmel wrote:
> On Sat, Apr 09, 2022 at 01:58:51PM +0300, Nikolay Aleksandrov wrote:
>> Hi,
>> This patch-set adds support to specify filtering conditions for a flush
>> operation. Initially only FDB flush filtering is added, later MDB
>> support will be added as well. Some user-space applications need a way
>> to delete only a specific set of entries, e.g. mlag implementations need
>> a way to flush only dynamic entries excluding externally learned ones
>> or only externally learned ones without static entries etc. Also apps
>> usually want to target only a specific vlan or port/vlan combination.
>> The current 2 flush operations (per port and bridge-wide) are not
>> extensible and cannot provide such filtering, so a new bridge af
>> attribute is added (IFLA_BRIDGE_FLUSH) which contains the filtering
>> information for each object type which has to be flushed.
>> An example structure for fdbs:
>>      [ IFLA_BRIDGE_FLUSH ]
>>       `[ BRIDGE_FDB_FLUSH ]
>>         `[ FDB_FLUSH_NDM_STATE ]
>>         `[ FDB_FLUSH_NDM_FLAGS ]
>>
>> I decided against embedding these into the old flush attributes for
>> multiple reasons - proper error handling on unsupported attributes,
>> older kernels silently flushing all, need for a second mechanism to
>> signal that the attribute should be parsed (e.g. using boolopts),
>> special treatment for permanent entries.
>>
>> Examples:
>> $ bridge fdb flush dev bridge vlan 100 static
>> < flush all static entries on vlan 100 >
>> $ bridge fdb flush dev bridge vlan 1 dynamic
>> < flush all dynamic entries on vlan 1 >
>> $ bridge fdb flush dev bridge port ens16 vlan 1 dynamic
>> < flush all dynamic entries on port ens16 and vlan 1 >
>> $ bridge fdb flush dev bridge nooffloaded nopermanent
>> < flush all non-offloaded and non-permanent entries >
>> $ bridge fdb flush dev bridge static noextern_learn
>> < flush all static entries which are not externally learned >
>> $ bridge fdb flush dev bridge permanent
>> < flush all permanent entries >
> 
> IIUC, the new IFLA_BRIDGE_FLUSH attribute is supposed to be passed in
> RTM_SETLINK messages, but the current 'bridge fdb' commands all
> correspond to RTM_{NEW,DEL,GET}NEIGH messages. To continue following
> this pattern, did you consider turning the above examples to the
> following?
> 

Yes, I did think about that but when I think about ip link set, I think about
configuring the bridge, while flush is an action similar to dump/show. Also
it's a special setlink with bridge address family similar to bridge/link.c.
More below..

> $ ip link set dev bridge type bridge fdb_flush vlan 100 static
> $ ip link set dev bridge type bridge fdb_flush vlan 1 dynamic
> $ ip link set dev ens16 type bridge_slave fdb_flush vlan 1 dynamic
> $ ip link set dev bridge type bridge fdb_flush nooffloaded nopermanent
> $ ip link set dev bridge type bridge fdb_flush static noextern_learn
> $ ip link set dev bridge type bridge fdb_flush permanent
> 
> It's not critical, but I like the correspondence between iproute2
> commands and the underlying netlink messages.
> 

Generally I agree with you, but in this case I'd prefer to keep them in bridge/(fdb|mdb).c.
Semantically I think fdb/mdb actions should be done through "bridge fdb/mdb" sub-commands. All
of the flush options are fdb/mdb-specific attributes which already exist there and shouldn't
be exposed in ip/. I know there are counterexamples of actions being done through ip link
(e.g. current flush) but those exist due to historic reasons. Another thing is that if it
becomes an ip link subcommand I'll either have to move the bridge family setlink into ip/ or
I'd have to make it a bridge attribute (i.e. extend the bridge option attributes). I don't
like the duplication that has been happening recently (same options added to bridge link and
to ip link set type bridge_slave for example), let's try and keep ip link set for bridge/bridge_slave
configuration only. Although it's still a SETLINK just in the bridge AF, we do have actions being
done through it already. That being said I don't mind changing it to DELLINK given that it's a
special case.

>>
>> Note that all flags have their negated version (static vs nostatic etc)
>> and there are some tricky cases to handle like "static" which in flag
>> terms means fdbs that have NUD_NOARP but *not* NUD_PERMANENT, so the
>> mask matches on both but we need only NUD_NOARP to be set. That's
>> because permanent entries have both set so we can't just match on
>> NUD_NOARP. Also note that this flush operation doesn't treat permanent
>> entries in a special way (fdb_delete vs fdb_delete_local), it will
>> delete them regardless if any port is using them. We can extend the api
>> with a flag to do that if needed in the future.
>>
>> Patches in this set:
>>  1. adds the new IFLA_BRIDGE_FLUSH bridge af attribute
>>  2. adds a basic structure to describe an fdb flush filter
>>  3. adds fdb netlink flush call via BRIDGE_FDB_FLUSH attribute
>>  4 - 6. add support for specifying various fdb fields to filter
>>
>> Patch-sets (in order):
>>  - Initial flush infra and fdb flush filtering (this set)
>>  - iproute2 support
>>  - selftests
>>
>> Future work:
>>  - mdb flush support
>>
>> Thanks,
>>  Nik
>>
>> Nikolay Aleksandrov (6):
>>   net: bridge: add a generic flush operation
>>   net: bridge: fdb: add support for fine-grained flushing
>>   net: bridge: fdb: add new nl attribute-based flush call
>>   net: bridge: fdb: add support for flush filtering based on ndm flags
>>     and state
>>   net: bridge: fdb: add support for flush filtering based on ifindex
>>   net: bridge: fdb: add support for flush filtering based on vlan id
>>
>>  include/uapi/linux/if_bridge.h |  22 ++++++
>>  net/bridge/br_fdb.c            | 128 +++++++++++++++++++++++++++++++--
>>  net/bridge/br_netlink.c        |  59 ++++++++++++++-
>>  net/bridge/br_private.h        |  12 +++-
>>  net/bridge/br_sysfs_br.c       |   6 +-
>>  5 files changed, 215 insertions(+), 12 deletions(-)
>>
>> -- 
>> 2.35.1
>>

