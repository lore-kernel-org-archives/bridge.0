Return-Path: <roopa@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs36UPeqkP8H3vA7VWWmygr1vvdGEr59iCCm2pyOkyc=;
 b=mQwSCkRBfJhIEX7lOT4d3RTCs2aUl9Rtqr/TwN/hCdu+jeheO+LDa3Sc2xACLgjBEz3wp2pRMZsPjg2+XNik1mrp5iKU/d2FmO2zLrT0Z5TNjrtC24O0hwWciGxSHy8p2VR4a/MiT1cdCKz/tLx2lBGMUAjr5hbjeKtjTza219KMMEwzTRqZ55AoC+BOXyY+CkTAFw1xRcWgq3WFveA26KptxSXqTPNh51Mw7zBIibaghF0aj50yYGxu4lb+poVoEh9jlrxp1OTZxIozxtnUaV6OrS7fUUQyx9+H8EKDJRiu0o8bXU45ZnTdM4wOAiXE8adISoAN9komH1wC6KqVMQ==
Message-ID: <ca093c4f-d99c-d885-16cb-240b0ce4d8d8@nvidia.com>
Date: Mon, 11 Apr 2022 12:22:24 -0700
Content-Language: en-US
References: <20220411172934.1813604-1-razor@blackwall.org>
 <0d08b6ce-53bb-bffa-4f04-ede9bfc8ab63@nvidia.com>
 <c46ac324-34a2-ca0c-7c8c-35dc9c1aa0ab@blackwall.org>
 <92f578b7-347e-22c7-be83-cae4dce101f6@blackwall.org>
From: Roopa Prabhu <roopa@nvidia.com>
In-Reply-To: <92f578b7-347e-22c7-be83-cae4dce101f6@blackwall.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v2 0/8] net: bridge: add flush
	filtering support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: idosch@idosch.org, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org


On 4/11/22 11:31, Nikolay Aleksandrov wrote:
> On 11/04/2022 21:18, Nikolay Aleksandrov wrote:
>> On 11/04/2022 21:08, Roopa Prabhu wrote:
>>> On 4/11/22 10:29, Nikolay Aleksandrov wrote:
>>>> Hi,
>>>> This patch-set adds support to specify filtering conditions for a flush
>>>> operation. This version has entirely different entry point (v1 had
>>>> bridge-specific IFLA attribute, here I add new RTM_FLUSHNEIGH msg and
>>>> netdev ndo_fdb_flush op) so I'll give a new overview altogether.
>>>> After me and Ido discussed the feature offlist, we agreed that it would
>>>> be best to add a new generic RTM_FLUSHNEIGH with a new ndo_fdb_flush
>>>> callback which can be re-used for other drivers (e.g. vxlan).
>>>> Patch 01 adds the new RTM_FLUSHNEIGH type, patch 02 then adds the
>>>> new ndo_fdb_flush call. With this structure we need to add a generic
>>>> rtnl_fdb_flush which will be used to do basic attribute validation and
>>>> dispatch the call to the appropriate device based on the NTF_USE/MASTER
>>>> flags (patch 03). Patch 04 then adds some common flush attributes which
>>>> are used by the bridge and vxlan drivers (target ifindex, vlan id, ndm
>>>> flags/state masks) with basic attribute validation, further validation
>>>> can be done by the implementers of the ndo callback. Patch 05 adds a
>>>> minimal ndo_fdb_flush to the bridge driver, it uses the current
>>>> br_fdb_flush implementation to flush all entries similar to existing
>>>> calls. Patch 06 adds filtering support to the new bridge flush op which
>>>> supports target ifindex (port or bridge), vlan id and flags/state mask.
>>>> Patch 07 converts ndm state/flags and their masks to bridge-private flags
>>>> and fills them in the filter descriptor for matching. Finally patch 08
>>>> fills in the target ifindex (after validating it) and vlan id (already
>>>> validated by rtnl_fdb_flush) for matching. Flush filtering is needed
>>>> because user-space applications need a quick way to delete only a
>>>> specific set of entries, e.g. mlag implementations need a way to flush only
>>>> dynamic entries excluding externally learned ones or only externally
>>>> learned ones without static entries etc. Also apps usually want to target
>>>> only a specific vlan or port/vlan combination. The current 2 flush
>>>> operations (per port and bridge-wide) are not extensible and cannot
>>>> provide such filtering.
>>>>
>>>> I decided against embedding new attrs into the old flush attributes for
>>>> multiple reasons - proper error handling on unsupported attributes,
>>>> older kernels silently flushing all, need for a second mechanism to
>>>> signal that the attribute should be parsed (e.g. using boolopts),
>>>> special treatment for permanent entries.
>>>>
>>>> Examples:
>>>> $ bridge fdb flush dev bridge vlan 100 static
>>>> < flush all static entries on vlan 100 >
>>>> $ bridge fdb flush dev bridge vlan 1 dynamic
>>>> < flush all dynamic entries on vlan 1 >
>>>> $ bridge fdb flush dev bridge port ens16 vlan 1 dynamic
>>>> < flush all dynamic entries on port ens16 and vlan 1 >
>>>> $ bridge fdb flush dev ens16 vlan 1 dynamic master
>>>> < as above: flush all dynamic entries on port ens16 and vlan 1 >
>>>> $ bridge fdb flush dev bridge nooffloaded nopermanent self
>>>> < flush all non-offloaded and non-permanent entries >
>>>> $ bridge fdb flush dev bridge static noextern_learn
>>>> < flush all static entries which are not externally learned >
>>>> $ bridge fdb flush dev bridge permanent
>>>> < flush all permanent entries >
>>>> $ bridge fdb flush dev bridge port bridge permanent
>>>> < flush all permanent entries pointing to the bridge itself >
>>>>
>>>> Note that all flags have their negated version (static vs nostatic etc)
>>>> and there are some tricky cases to handle like "static" which in flag
>>>> terms means fdbs that have NUD_NOARP but *not* NUD_PERMANENT, so the
>>>> mask matches on both but we need only NUD_NOARP to be set. That's
>>>> because permanent entries have both set so we can't just match on
>>>> NUD_NOARP. Also note that this flush operation doesn't treat permanent
>>>> entries in a special way (fdb_delete vs fdb_delete_local), it will
>>>> delete them regardless if any port is using them. We can extend the api
>>>> with a flag to do that if needed in the future.
>>>>
>>>> Patch-sets (in order):
>>>>    - Initial flush infra and fdb flush filtering (this set)
>>>>    - iproute2 support
>>>>    - selftests
>>>>
>>>> Future work:
>>>>    - mdb flush support (RTM_FLUSHMDB type)
>>>>
>>>> Thanks to Ido for the great discussion and feedback while working on this.
>>>>
>>> Cant we pile this on to RTM_DELNEIGH with a flush flag ?.
>>>
>>> It is a bulk del, and sounds seems similar to the bulk dev del discussion on netdev a few months ago (i dont remember how that api ended up to be. unless i am misremembering).
>>>
>>> neigh subsystem also needs this, curious how this api will work there.
>>>
>>> (apologies if you guys already discussed this, did not have time to look through all the comments)
>>>
>>>
>>>
>> I thought about that option, but I didn't like overloading delneigh like that.
>> del currently requires a mac address and we need to either signal the device supports> a null mac, or we should push that verification to ndo_fdb_del users. Also we'll have
> that's the only thing, overloading delneigh with a flush-behaviour (multi-del or whatever)
> would require to push the mac check to ndo_fdb_del implementers
>
> I don't mind going that road if others agree that we should do it through delneigh
> + a bit/option to signal flush, instead of a new rtm type.
>
>> attributes which are flush-specific and will work only when flushing as opposed to when
>> deleting a specific mac, so handling them in the different cases can become a pain.
> scratch the specific attributes, those can be adapted for both cases
>
>> MDBs will need DELMDB to be modified in a similar way.
>>
>> IMO a separate flush op is cleaner, but I don't have a strong preference.
>> This can very easily be adapted to delneigh with just a bit more mechanical changes
>> if the mac check is pushed to the ndo implementers.
>>
>> FLUSHNEIGH can easily work for neighs, just need another address family rtnl_register
>> that implements it, the new ndo is just for PF_BRIDGE. :)

all great points. My only reason to explore RTM_DELNEIGH is to see if we 
can find a recipe to support similar bulk deletes of other objects 
handled via rtm msgs in the future. Plus, it allows you to maintain 
symmetry between flush requests and object delete notification msg types.

Lets see if there are other opinions.

Thanks Nikolay



