Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Qn0m42DURCvgyA+3fQ3KmY2jO1hPwl7SsCJTQkfJV1s=;
 b=hMkj2kvMUd7imAmQLdIxKRb5Y6stYgX2688k9Otvb5DuBuGpKEVIzX2kLC0il0bbuC
 Dxg8JbTm4UWxbe/cvYxUsKKiAq9QEEvmvHMKr7WnRrnIEf3kz9qvX1sPKAQW45TVLtuo
 fP7XB81maT1NwKW4v3GZ+j2t29xaKL8mD/u4X7aMrGAfrSiz9ha6Mv5ywKLv3sRWrOyq
 Ou/uXdcDhayTAVeJLZkyHql3VVGDXBNGZ4O2vP9fb5SxgaI9qXBg1noS+UbhEC+UQKF8
 PMw3KVI33DheavQ7MDCthvZxpI4Q1hV0sKBug/5/3H5tSnyZVIXZ+fzHE7oAlN120maL
 6/dQ==
Message-ID: <e3655cbf-5b8f-85d1-cd5f-80df739d79f4@blackwall.org>
Date: Mon, 11 Apr 2022 20:42:51 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220411172934.1813604-1-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220411172934.1813604-1-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: netdev@vger.kernel.org
Cc: idosch@idosch.org, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com

On 11/04/2022 20:29, Nikolay Aleksandrov wrote:
> Hi,
> This patch-set adds support to specify filtering conditions for a flush
> operation. This version has entirely different entry point (v1 had
> bridge-specific IFLA attribute, here I add new RTM_FLUSHNEIGH msg and
> netdev ndo_fdb_flush op) so I'll give a new overview altogether.
> After me and Ido discussed the feature offlist, we agreed that it would
> be best to add a new generic RTM_FLUSHNEIGH with a new ndo_fdb_flush
> callback which can be re-used for other drivers (e.g. vxlan).
> Patch 01 adds the new RTM_FLUSHNEIGH type, patch 02 then adds the
> new ndo_fdb_flush call. With this structure we need to add a generic
> rtnl_fdb_flush which will be used to do basic attribute validation and
> dispatch the call to the appropriate device based on the NTF_USE/MASTER
> flags (patch 03). Patch 04 then adds some common flush attributes which
> are used by the bridge and vxlan drivers (target ifindex, vlan id, ndm
> flags/state masks) with basic attribute validation, further validation
> can be done by the implementers of the ndo callback. Patch 05 adds a
> minimal ndo_fdb_flush to the bridge driver, it uses the current
> br_fdb_flush implementation to flush all entries similar to existing
> calls. Patch 06 adds filtering support to the new bridge flush op which
> supports target ifindex (port or bridge), vlan id and flags/state mask.
> Patch 07 converts ndm state/flags and their masks to bridge-private flags
> and fills them in the filter descriptor for matching. Finally patch 08

Aargh.. I mixed up the patch numbers above. Patch 03 adds the minimal ndo_fdb_flush
to the bridge driver (not patch 05), patch 04 adds the generic rtnl_fdb_flush
(not patch 03) and patch 05 adds the common attributes (not patch 04).

Let me know if you'd like me to repost it with fixed numbers. I'll wait for
feedback anyway.

> fills in the target ifindex (after validating it) and vlan id (already
> validated by rtnl_fdb_flush) for matching. Flush filtering is needed> because user-space applications need a quick way to delete only a
> specific set of entries, e.g. mlag implementations need a way to flush only
> dynamic entries excluding externally learned ones or only externally
> learned ones without static entries etc. Also apps usually want to target
> only a specific vlan or port/vlan combination. The current 2 flush
> operations (per port and bridge-wide) are not extensible and cannot
> provide such filtering.



