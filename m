Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:user-agent:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=ph+b6vEsWKwHnBUnlrg/LEJgtkhSmZYe3Lw1mNpS7CI=;
 b=7GuhuVtC3u8UnVwuZhUgtoEzCBmlt85sYwX+st0ZrgtcOnomUhTd6iDkv/nAUakm9x
 jtrUgk4JN3CAd+qFy2qeyTkjbSfyqNM8kRB2oChajlmgiKkeL5QtFKr9iDxUTfqYfXDt
 vZe+4AM6tUaHZotVlJsLR16vVLvPQj9n7EAY4h6xe9xzVrit711zhqpt6O5MD7ZrmWRQ
 oM/CTx7somdyGY4Ja7rJD0WfJivLe1s6G/1+J4M92MFHoeSGGUWU6cULMHDHeZXziRUF
 cMnWEEemDTKucMUmzaGmSNhKRKxjVaSOAmPXkmGIPvdnIG0Kk8v48LqC7eT9iOxWXyaG
 914g==
Date: Sat, 09 Apr 2022 15:36:59 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220409105857.803667-1-razor@blackwall.org>
References: <20220409105857.803667-1-razor@blackwall.org>
Message-ID: <133ACD1C-F64D-499B-BE66-4EDA3598A35C@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On 9 April 2022 13:58:51 EEST, Nikolay Aleksandrov <razor@blackwall=2Eorg> =
wrote:
>Hi,
>This patch-set adds support to specify filtering conditions for a flush
>operation=2E Initially only FDB flush filtering is added, later MDB
>support will be added as well=2E Some user-space applications need a way
>to delete only a specific set of entries, e=2Eg=2E mlag implementations n=
eed
>a way to flush only dynamic entries excluding externally learned ones
>or only externally learned ones without static entries etc=2E Also apps
>usually want to target only a specific vlan or port/vlan combination=2E
>The current 2 flush operations (per port and bridge-wide) are not
>extensible and cannot provide such filtering, so a new bridge af
>attribute is added (IFLA_BRIDGE_FLUSH) which contains the filtering
>information for each object type which has to be flushed=2E
>An example structure for fdbs:
>     [ IFLA_BRIDGE_FLUSH ]
>      `[ BRIDGE_FDB_FLUSH ]
>        `[ FDB_FLUSH_NDM_STATE ]
>        `[ FDB_FLUSH_NDM_FLAGS ]
>
>I decided against embedding these into the old flush attributes for
>multiple reasons - proper error handling on unsupported attributes,
>older kernels silently flushing all, need for a second mechanism to
>signal that the attribute should be parsed (e=2Eg=2E using boolopts),
>special treatment for permanent entries=2E
>
>Examples:
>$ bridge fdb flush dev bridge vlan 100 static
>< flush all static entries on vlan 100 >
>$ bridge fdb flush dev bridge vlan 1 dynamic
>< flush all dynamic entries on vlan 1 >
>$ bridge fdb flush dev bridge port ens16 vlan 1 dynamic
>< flush all dynamic entries on port ens16 and vlan 1 >
>$ bridge fdb flush dev bridge nooffloaded nopermanent
>< flush all non-offloaded and non-permanent entries >
>$ bridge fdb flush dev bridge static noextern_learn
>< flush all static entries which are not externally learned >
>$ bridge fdb flush dev bridge permanent
>< flush all permanent entries >
>
>Note that all flags have their negated version (static vs nostatic etc)
>and there are some tricky cases to handle like "static" which in flag
>terms means fdbs that have NUD_NOARP but *not* NUD_PERMANENT, so the
>mask matches on both but we need only NUD_NOARP to be set=2E That's
>because permanent entries have both set so we can't just match on
>NUD_NOARP=2E Also note that this flush operation doesn't treat permanent
>entries in a special way (fdb_delete vs fdb_delete_local), it will
>delete them regardless if any port is using them=2E We can extend the api
>with a flag to do that if needed in the future=2E
>
>Patches in this set:
> 1=2E adds the new IFLA_BRIDGE_FLUSH bridge af attribute
> 2=2E adds a basic structure to describe an fdb flush filter
> 3=2E adds fdb netlink flush call via BRIDGE_FDB_FLUSH attribute
> 4 - 6=2E add support for specifying various fdb fields to filter
>
>Patch-sets (in order):
> - Initial flush infra and fdb flush filtering (this set)
> - iproute2 support
> - selftests
>
>Future work:
> - mdb flush support
>
>Thanks,
> Nik
>
>Nikolay Aleksandrov (6):
>  net: bridge: add a generic flush operation
>  net: bridge: fdb: add support for fine-grained flushing
>  net: bridge: fdb: add new nl attribute-based flush call
>  net: bridge: fdb: add support for flush filtering based on ndm flags
>    and state
>  net: bridge: fdb: add support for flush filtering based on ifindex
>  net: bridge: fdb: add support for flush filtering based on vlan id
>
> include/uapi/linux/if_bridge=2Eh |  22 ++++++
> net/bridge/br_fdb=2Ec            | 128 +++++++++++++++++++++++++++++++--
> net/bridge/br_netlink=2Ec        |  59 ++++++++++++++-
> net/bridge/br_private=2Eh        |  12 +++-
> net/bridge/br_sysfs_br=2Ec       |   6 +-
> 5 files changed, 215 insertions(+), 12 deletions(-)
>

Actually if you prefer I can send the selftests with this set, I'm used to=
 sending them last
after the iproute2 support is finalised=2E :)

Cheers,
  Nik
